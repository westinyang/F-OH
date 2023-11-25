# F-OH Server

## 项目介绍

F-OH 服务器，提供接口服务、平台管理等（待开发）

## 技术选型

- Java SpringBoot `首选`
- Go Gin `备选`
- Python Flask `备选`

## 初步构想

- 角色权限
    - 管理员，所有权限
    - 开发者，提交应用、查看自己已提交的应用列表及状态
- 功能模块
    - /api `接口服务，提供F-OH客户端所需的HTTP接口`
    - /platform `平台管理`
        - /login `登录`
        - /register `开发者注册`
        - /dev `开发者中心，提交应用、查看已提交的应用和审核状态`
        - /index `首页统计`
        - /app `应用管理、审核`
        - /settings `平台设置（公告等）`
