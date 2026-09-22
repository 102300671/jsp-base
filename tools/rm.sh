#!/usr/bin/env bash
set -uo pipefail

# 幂等移除作业子模块
# 用法: ./tools/rm.sh [-y] [--keep-post] <名称>
# 自动在 webapp/lab*/ 和 java/.../lab*/ 下查找模块

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
JSP_DIR="$ROOT_DIR/jsp-src"
WEBAPP="$JSP_DIR/src/main/webapp"
JAVA_PKG="$JSP_DIR/src/main/java/place/run/jianying"
PORTAL="$WEBAPP/index.jsp"

ASSUME_YES=0; KEEP_POST=0; MODULE=""
while [ $# -gt 0 ]; do
  case "$1" in
    -y|--yes)    ASSUME_YES=1; shift ;;
    --keep-post) KEEP_POST=1; shift ;;
    -h|--help)   echo "用法: $0 [-y] [--keep-post] <名称>"; exit 0 ;;
    -*) echo "未知选项: $1" >&2; exit 1 ;;
    *)  MODULE="$1"; shift ;;
  esac
done

[ -n "$MODULE" ] || { echo "请指定模块名" >&2; exit 1; }
[[ "$MODULE" =~ ^[a-z0-9][a-z0-9-]*$ ]] || { echo "非法名称" >&2; exit 1; }

PKG="${MODULE//-/}"

# 在 lab*/ 下查找 webapp 和 java 模块目录
MODULE_WEB=$(find "$WEBAPP" -maxdepth 2 -type d -name "$MODULE" 2>/dev/null | head -1 || true)
MODULE_JAVA=$(find "$JAVA_PKG" -maxdepth 2 -type d -name "$PKG" 2>/dev/null | head -1 || true)
POSTS=$(ls "$ROOT_DIR/_posts"/*"-${MODULE}.md" 2>/dev/null || true)

# portal 中是否存在该模块的导航项
PORTAL_HAS=0
if [ -f "$PORTAL" ] && grep -q "/jsp-base/lab" "$PORTAL" && grep -q "/$MODULE/" "$PORTAL"; then
  PORTAL_HAS=1
fi

echo "将要删除："
[ -n "$MODULE_WEB" ]  && echo "  - ${MODULE_WEB#$ROOT_DIR/}/"
[ -n "$MODULE_JAVA" ] && echo "  - ${MODULE_JAVA#$ROOT_DIR/}/"
[ $PORTAL_HAS -eq 1 ] && echo "  - portal 导航项"
if [ $KEEP_POST -eq 0 ] && [ -n "$POSTS" ]; then
  echo "$POSTS" | while read -r p; do echo "  - _posts/$(basename "$p")"; done
fi

if [ -z "$MODULE_WEB" ] && [ -z "$MODULE_JAVA" ]    && [ $PORTAL_HAS -eq 0 ]    && { [ $KEEP_POST -eq 1 ] || [ -z "$POSTS" ]; }
then
  echo "  （无）"
  echo ""
  echo "✅ 无需操作"
  exit 0
fi

if [ $ASSUME_YES -ne 1 ]; then
  echo ""
  printf '确认？[y/N] '
  read -r ans
  case "$ans" in y|Y|yes|YES) ;; *) echo "已取消"; exit 0 ;; esac
fi

echo ""
log() { printf '%s\n' "$*"; }

git_rm() {
  local path="$1"
  local rel="${path#$ROOT_DIR/}"
  if git -C "$ROOT_DIR" rev-parse --git-dir >/dev/null 2>&1      && git -C "$ROOT_DIR" ls-files --error-unmatch "$rel" >/dev/null 2>&1
  then
    git -C "$ROOT_DIR" rm -r -q --ignore-unmatch "$rel"
  else
    rm -rf "$path"
  fi
}

if [ -n "$MODULE_WEB" ]; then
  WEB_LAB=$(dirname "$MODULE_WEB")
  git_rm "$MODULE_WEB"
  log "  [remove] ${MODULE_WEB#$ROOT_DIR/}/"
  # 清理空的 lab 目录
  if [ -d "$WEB_LAB" ] && [ -z "$(ls -A "$WEB_LAB")" ]; then
    rmdir "$WEB_LAB" 2>/dev/null && log "  [cleanup] ${WEB_LAB#$ROOT_DIR/}/（空目录）"
  fi
fi

if [ -n "$MODULE_JAVA" ]; then
  JAVA_LAB=$(dirname "$MODULE_JAVA")
  git_rm "$MODULE_JAVA"
  log "  [remove] ${MODULE_JAVA#$ROOT_DIR/}/"
  if [ -d "$JAVA_LAB" ] && [ -z "$(ls -A "$JAVA_LAB")" ]; then
    rmdir "$JAVA_LAB" 2>/dev/null && log "  [cleanup] ${JAVA_LAB#$ROOT_DIR/}/（空目录）"
  fi
fi

# portal 导航：删除包含 /jsp-base/lab.../<module>/ 的整个 <li> 块
if [ $PORTAL_HAS -eq 1 ]; then
  awk -v mod="$MODULE" '
    /<li data-chapter=/ { in_li=1; buf=$0 "\n"; remove=0; next }
    in_li {
      buf = buf $0 "\n"
      if (index($0, "/jsp-base/lab") > 0 && index($0, "/" mod "/") > 0) remove=1
      if ($0 ~ /<\/li>/) {
        if (!remove) printf "%s", buf
        in_li=0; buf=""; remove=0
      }
      next
    }
    { print }
  ' "$PORTAL" > "$PORTAL.tmp" && mv "$PORTAL.tmp" "$PORTAL"
  log "  [remove] portal 导航项"
fi

if [ $KEEP_POST -eq 0 ] && [ -n "$POSTS" ]; then
  echo "$POSTS" | while read -r p; do
    [ -n "$p" ] || continue
    rel="${p#$ROOT_DIR/}"
    if git -C "$ROOT_DIR" rev-parse --git-dir >/dev/null 2>&1        && git -C "$ROOT_DIR" ls-files --error-unmatch "$rel" >/dev/null 2>&1
    then
      git -C "$ROOT_DIR" rm -q --ignore-unmatch "$rel"
    else
      rm -f "$p"
    fi
    log "  [remove] _posts/$(basename "$p")"
  done
fi

log ""
log "✅ 完成：$MODULE 已移除"
