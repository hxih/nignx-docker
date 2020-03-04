# nignx-docker
基于官方镜像nginx:1.15-alpine改造
## 改造内容
原官方nginx镜像日志文件输出到/dev/stdout
修改为输出到文件/var/log/nginx/access.log、error.log
并加入可执行脚本rotatelog.sh，放入定时任务/etc/periodic/hourly/目录下，每小时轮动nginx日志文件
同时新建一个启动nginx脚本start.sh，再把access.log,error.log日志文件tail -f 输出到/dev/stdout，以便docker logs查看日志
