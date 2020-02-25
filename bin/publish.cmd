@echo off
cd %~dp0\..
zola build
bash -c "scp -Cr public/* eric@blog.digitalsorcery.net:/www/blog/"
