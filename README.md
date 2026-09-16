# jsp-base

JSP 课程作业的源码与实现记录。

基于 [Chirpy](https://github.com/cotes2020/jekyll-theme-chirpy) Jekyll 主题构建博客站点，每章作业以「博客文章 + 可运行源码（Maven WAR 工程）」形式组织。

- 博客：<https://102300671.github.io/jsp-base>
- 作者：102300671

## 仓库结构

```text
.
├── _config.yml          # Jekyll 站点配置
├── _data/               # 站点数据
├── _plugins/            # Jekyll 插件（源码嵌入、文章最后修改时间）
├── _posts/              # 作业记录文章（每章一篇）
├── _tabs/               # 页面标签
├── assets/              # 静态资源
├── tools/               # 脚手架脚本
│   ├── new.sh           # 幂等创建作业子模块
│   ├── rm.sh            # 幂等移除作业子模块
│   ├── run.sh           # 本地运行博客
│   └── test.sh          # 构建并测试站点
└── jsp-src/             # JSP 作业工程（Maven WAR）
    ├── pom.xml
    └── src/main/
        ├── java/place/run/jianying/  # Java 源码（按章节分包）
        ├── resources/                # 资源文件
        └── webapp/                   # JSP 页面与 WEB-INF
```

## 博客：本地运行

```bash
# 安装依赖
bundle install

# 本地预览（默认 http://127.0.0.1:4000）
bash tools/run.sh

# 生产构建
JEKYLL_ENV=production bundle exec jekyll build

# 构建并测试（html-proofer）
bash tools/test.sh
```

## JSP 作业工程

`jsp-src/` 是 Maven 管理的 JSP 课程作业工程：

| 项目 | 值 |
|---|---|
| groupId / artifactId | `place.run.jianying` / `jsp-base` |
| 打包方式 | war |
| Java 版本 | 17 |
| Servlet API | 4.0.1（provided） |

### 构建与部署

```bash
cd jsp-src
mvn package        # 生成 target/jsp-base.war
```

将 WAR 部署到 Tomcat，或直接把 `src/main/webapp` 作为 Web 应用目录：

```bash
service tomcat10 start
```

访问：

- 本地：<http://localhost:8080/jsp-base/>
- 云服务器：<http://59.110.163.88:8080/jsp-base/>（部署后可用）

> GitHub Pages 是纯静态托管，无法执行 JSP；作业页面需在 Tomcat 中运行。

### 章节列表

| 章节 | 模块 | 说明 | 访问路径 |
|---|---|---|---|
| 01 | info | 信息页：输出学号与服务器时间 | `/jsp-base/info/` |

## 新增作业章节

脚手架幂等创建（可重复执行，已存在则跳过）：

```bash
bash tools/new.sh <序号> <名称> [显示标题] [描述]

# 示例：创建第 02 章「个人主页」
bash tools/new.sh 2 homepage "个人主页" "HTML/CSS 基础"
```

脚本自动完成：

1. 创建 `jsp-src/src/main/webapp/<名称>/` 页面目录（含模板 `index.jsp`）
2. 创建 `jsp-src/src/main/java/place/run/jianying/<包名>/` Java 包
3. 在导航门户 `jsp-src/src/main/webapp/index.jsp` 插入入口链接
4. 生成博客文章 `_posts/<日期>-<名称>.md`（含源码嵌入与本地/云服务器运行地址）

移除章节：

```bash
bash tools/rm.sh [-y] [--keep-post] <名称>
```

## 技术栈

- Jekyll + Chirpy 主题（博客）
- JSP / Servlet（javax.servlet 4.0.1）
- Maven / Java 17
- Tomcat 10

## 许可证

[MIT](./LICENSE)
