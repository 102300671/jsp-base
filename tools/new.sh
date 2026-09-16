#!/usr/bin/env bash
set -uo pipefail

# 幂等创建作业子模块
# 用法: ./tools/new-hw.sh <序号> <名称> [显示标题] [描述]

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
JSP_DIR="$ROOT_DIR/jsp-src"
WEBAPP="$JSP_DIR/src/main/webapp"
JAVA_PKG="$JSP_DIR/src/main/java/place/run/jianying"
PORTAL="$WEBAPP/index.jsp"
MARKER="<!-- NEW_HW_HERE -->"
URL_BASE="${URL_BASE:-http://localhost:8080/jsp-base}"
SERVER_URL_BASE="${SERVER_URL_BASE:-http://59.110.163.88:8080/jsp-base}"

log()  { printf '%s\n' "$*"; }
ok()   { printf '  \033[32m[create]\033[0m %s\n' "$*"; }
skip() { printf '  \033[90m[skip]\033[0m   %s\n' "$*"; }
warn() { printf '  \033[33m[warn]\033[0m   %s\n' "$*" >&2; }
die()  { printf '\033[31m错误:\033[0m %s\n' "$*" >&2; exit 1; }

if [ $# -lt 2 ]; then
  cat >&2 <<EOF
用法: $0 <序号> <名称> [显示标题] [描述]

示例:
  $0 1 homepage "个人主页" "HTML/CSS 基础"
  $0 3 login    "用户登录" "Servlet + Session"
EOF
  exit 1
fi

NUM_RAW="$1"; NAME="$2"
TITLE="${3:-$NAME}"; DESC="${4:-}"

[[ "$NUM_RAW" =~ ^[0-9]+$ ]] || die "序号必须是数字"
NUM=$(printf "%02d" "$NUM_RAW")
[[ "$NAME" =~ ^[a-z0-9][a-z0-9-]*$ ]] || die "名称只能小写字母/数字/连字符"

MODULE="$NAME"
PKG="${NAME//-/}"                     # 包名去连字符
MODULE_WEB="$WEBAPP/$MODULE"
MODULE_JAVA="$JAVA_PKG/$PKG"

[ -d "$JSP_DIR" ] || die "找不到 $JSP_DIR"

log "▶ 处理模块 $MODULE（第 $NUM 章）"

# 1) webapp 子目录
if [ -d "$MODULE_WEB" ]; then skip "jsp-src/src/main/webapp/$MODULE/"
else mkdir -p "$MODULE_WEB"; ok "jsp-src/src/main/webapp/$MODULE/"; fi

# 2) index.jsp
IDX="$MODULE_WEB/index.jsp"
if [ -f "$IDX" ]; then
  skip "jsp-src/src/main/webapp/$MODULE/index.jsp"
else
  cat > "$IDX" <<EOF
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="UTF-8">
  <title>$TITLE</title>
</head>
<body>
  <h1>$TITLE</h1>
  <p>待实现。</p>
</body>
</html>
EOF
  ok "jsp-src/src/main/webapp/$MODULE/index.jsp"
fi

# 3) java 包
if [ -d "$MODULE_JAVA" ]; then
  skip "jsp-src/src/main/java/place/run/jianying/$PKG/"
else
  mkdir -p "$MODULE_JAVA"
  ok "jsp-src/src/main/java/place/run/jianying/$PKG/"
fi

# 4) portal 导航
if [ ! -f "$PORTAL" ]; then
  warn "找不到 $PORTAL（跳过导航）"
elif ! grep -q "$MARKER" "$PORTAL"; then
  warn "$PORTAL 里没有 $MARKER 标记（跳过导航）"
elif grep -q "href=\"/jsp-base/$MODULE/\"" "$PORTAL"; then
  skip "portal 已含 $MODULE 导航项"
else
  DESC_LINE="      <div class=\"desc\">第 $NUM 章${DESC:+ · $DESC}</div>"
  awk -v marker="$MARKER" -v mod="$MODULE" -v title="$TITLE" \
      -v desc="$DESC_LINE" -v chap="$NUM" '
    index($0, marker) && !done {
      print "    <li data-chapter=\"" chap "\">"
      print "      <a href=\"/jsp-base/" mod "/\">第 " chap " 章 · " title "</a>"
      print desc
      print "    </li>"
      done=1
    }
    { print }
  ' "$PORTAL" > "$PORTAL.tmp" && mv "$PORTAL.tmp" "$PORTAL"
  ok "portal 导航插入"
fi

# 5) _posts
TODAY=$(date +%Y-%m-%d)
POST_FILE="$ROOT_DIR/_posts/${TODAY}-${MODULE}.md"
EXISTING=$(ls "$ROOT_DIR/_posts"/*"-${MODULE}.md" 2>/dev/null | head -1 || true)
if [ -n "${EXISTING:-}" ]; then
  skip "文章已存在: ${EXISTING#$ROOT_DIR/}"
else
  mkdir -p "$ROOT_DIR/_posts"
  cat > "$POST_FILE" <<EOF
---
layout: post
title: "第 $NUM 章 · $TITLE"
date: $(date '+%Y-%m-%d %H:%M:%S %z')
chapter: $NUM_RAW
categories: [作业, JSP]
tags: [JSP]
---

> **运行地址：**
> - 本地：<$URL_BASE/$MODULE/>
> - 云服务器：<$SERVER_URL_BASE/$MODULE/>
>
> 本章是动态 JSP 页面，需在 Tomcat 中运行才能访问；GitHub Pages 是纯静态托管，无法执行 JSP。
> 本地启动：\`service tomcat10 start\`

## 源码

{% include_tree jsp-src/src/main/webapp/$MODULE jsp,html,css,js %}
EOF
  ok "_posts/${TODAY}-${MODULE}.md"
fi

log ""
log "✅ 完成：$MODULE（第 $NUM 章）"
log ""
log "访问:   $URL_BASE/$MODULE/（本地）"
log "          $SERVER_URL_BASE/$MODULE/（云服务器）"
log "改完 Java 后:  cd jsp-src && mvn -q compile"
