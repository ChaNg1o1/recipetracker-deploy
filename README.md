# RecipeTracker Koyeb 部署

这是 RecipeTracker 的 Koyeb 部署仓库，使用 ttyd 将控制台程序转换为 Web 终端。

## 仓库内容

```
deploy/
├── Dockerfile
├── RecipeTracker-1.0-SNAPSHOT.jar
└── README.md
```

## 部署步骤

### 1. 准备工作

确保 JAR 包已使用 TiDB 云数据库配置构建：

```bash
# 在主项目目录
mvn clean package
cp target/RecipeTracker-1.0-SNAPSHOT.jar deploy/
```

### 2. 推送到 GitHub

```bash
cd deploy
git init
git add .
git commit -m "Initial deployment"
git remote add origin https://github.com/你的用户名/recipetracker-deploy.git
git push -u origin main
```

### 3. 在 Koyeb 部署

1. 登录 [Koyeb 控制台](https://app.koyeb.com/)
2. 点击 **Create Service** → **GitHub**
3. 连接你的 GitHub 账户并选择 `recipetracker-deploy` 仓库
4. 配置构建设置：
   - **Builder**: Dockerfile
   - **Dockerfile location**: `Dockerfile`
5. 配置服务设置：
   - **Port**: `8000`
   - **Instance type**: 选择合适的实例（推荐 Nano 起步）
6. 配置环境变量（可选，用于覆盖默认认证）：
   - `TTYD_USER`: 你的用户名
   - `TTYD_PASS`: 你的密码
7. 点击 **Deploy**

### 4. 访问应用

部署完成后，Koyeb 会提供一个 URL，例如：
```
https://recipetracker-deploy-你的ID.koyeb.app
```

使用浏览器访问，输入用户名密码即可使用控制台应用。

## 认证信息

**默认凭据**（建议通过环境变量修改）：
- 用户名: `admin`
- 密码: `recipetracker123`

> ⚠️ **安全提示**: 请在 Koyeb 控制台的环境变量中设置自定义的用户名和密码！

## 更新应用

当你更新了 Java 代码后：

```bash
# 1. 重新构建 JAR
mvn clean package

# 2. 复制到 deploy 目录
cp target/RecipeTracker-1.0-SNAPSHOT.jar deploy/

# 3. 推送更新
cd deploy
git add .
git commit -m "Update application"
git push
```

Koyeb 会自动检测推送并重新部署。
