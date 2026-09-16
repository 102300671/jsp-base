#!/usr/bin/env bash
set -uo pipefail

# 幂等移除作业子模块
# 用法: ./tools/rm-hw.sh [-y] [--keep-post] <名称>

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
MODULE_WEB="$WEBAPP/$MODULE"
MODULE_JAVA="$JAVA_PKG/$PKG"
POSTS=$(ls "$ROOT_DIR/_posts"/*"-${MODULE}.md" 2>/dev/null || true)

echo "将要删除："
[ -d "$MODULE_WEB" ]  && echo "  - jsp-src/src/main/webapp/$MODULE/"
[ -d "$MODULE_JAVA" ] && echo "  - jsp-src/src/main/java/place/run/jianying/$PKG/"
[ -f "$PORTAL" ] && grep -q "href=\"/jsp-base/$MODULE/\"" "$PORTAL" 2>/dev/null \
  && echo "  - portal 导航项"
if [ $KEEP_POST -eq 0 ] && [ -n "$POSTS" ]; then
  echo "$POSTS" | while read -r p; do echo "  - _posts/$(basename "$p")"; done
fi

if [ ! -d "$MODULE_WEB" ] && [ ! -d "$MODULE_JAVA" ] \
   && { [ ! -f "$PORTAL" ] || ! grep -q "href=\"/jsp-base/$MODULE/\"" "$PORTAL" 2>/dev/null; } \
   && { [ $KEEP_POST -eq 1 ] || [ -z "$POSTS" ]; }
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
  local rel="$1"
  if git -C "$ROOT_DIR" rev-parse --git-dir >/dev/null 2>&1 \
     && git -C "$ROOT_DIR" ls-files --error-unmatch "$rel" >/dev/null 2>&1
  then
    git -C "$ROOT_DIR" rm -r -q --ignore-unmatch "$rel"
  else
    rm -rf "$ROOT_DIR/$rel"
  fi
}

if [ -d "$MODULE_WEB" ]; then
  git_rm "jsp-src/src/main/webapp/$MODULE"
  log "  [remove] jsp-src/src/main/webapp/$MODULE/"
fi

if [ -d "$MODULE_JAVA" ]; then
  git_rm "jsp-src/src/main/java/place/run/jianying/$PKG"
  log "  [remove] jsp-src/src/main/java/place/run/jianying/$PKG/"
fi

if [ -f "$PORTAL" ] && grep -q "href=\"/jsp-base/$MODULE/\"" "$PORTAL"; then
  awk -v mod="href=\"/jsp-base/$MODULE/\"" '
    /<li data-chapter=/ { in_li=1; buf=$0 "\n"; keep=0; next }
    in_li {
      buf = buf $0 "\n"
      if (index($0, mod) > 0) keep=1
      if ($0 ~ /<\/li>/) {
        if (keep) printf "%s", buf
        in_li=0; buf=""
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
    if git -C "$ROOT_DIR" rev-parse --git-dir >/dev/null 2>&1 \
       && git -C "$ROOT_DIR" ls-files --error-unmatch "$rel" >/dev/null 2>&1
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
