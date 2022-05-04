@echo off

if [%1]==[] goto usage
@echo Building image jdk-docker-awscli-kubectl with version %1
docker build -t emagiz/jdk-docker-awscli-kubectl:%1 -t emagiz/jdk-docker-awscli-kubectl:latest .
docker push emagiz/jdk-docker-awscli-kubectl:%1
docker push emagiz/jdk-docker-awscli-kubectl:latest
goto :eof

:usage
@echo No argument supplied, we need a version in the form of 1.0.0 to build this image
@echo Usage: docker-build.bat 1.0.0
exit /B 1