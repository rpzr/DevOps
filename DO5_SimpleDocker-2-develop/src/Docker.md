## Part 1. Готовый докер

Возьмем официальный докер-образ с **nginx** и скачаем его с помощью `docker pull`, а затем проверим его наличие с помощью `docker images`

![SCREENSHOT..Part1.docker.pull](screens/Part1.docker.pull.jpg)

Запустим докер-образ через `docker run -d [image_id|repository]` и проверим, что образ запустился через `docker ps`

![SCREENSHOT..Part1.docker.run](screens/Part1.docker.run.jpg)

Посмотрим информацию о контейнере через `docker inspect`

**Размер контейнера**

![SCREENSHOT..Part1.size](screens/Part1.size.jpg)

**Список замапленных портов**

![SCREENSHOT..Part1.ports](screens/Part1.ports.jpg)

**IP контейнера**

![SCREENSHOT..Part1.ip](screens/Part1.ip.jpg)

Остановим докер контейнер через `docker stop [container_id|container_name]` и проверим, что контейнер остановился через `docker ps`

![SCREENSHOT..Part1.docker.stop](screens/Part1.docker.stop.jpg)

Запустим докер с портами 80 и 443 в контейнере, замапленными на такие же порты на локальной машине, через команду *run*

![SCREENSHOT..Part1.docker.run.with.ports](screens/Part1.docker.run.with.ports.jpg)

Проверим, что в браузере по адресу *localhost:80* доступна стартовая страница **nginx**.

![SCREENSHOT..Part1.docker.check.nginx](screens/Part1.docker.check.nginx.jpg)

Перезапустим докер контейнер через `docker restart [container_id|container_name]` и  проверим, что он запустился

![SCREENSHOT..Part1.docker.restart](screens/Part1.docker.restart.jpg)

## Part 2. Операции с контейнером

Прочитаем конфигурационный файл *nginx.conf* внутри докер контейнера через команду *exec*.

![SCREENSHOT..Part2.start.nginxconf](screens/Part2.start.nginxconf.jpg)

Создадим на локальной машине файл *nginx.conf* и настроим в нем по пути */status* отдачу страницы статуса сервера **nginx**

![SCREENSHOT..Part2.nginxconf](screens/Part2.nginxconf.jpg)

Скопируем созданный файл *nginx.conf* внутрь докер-образа через команду `docker cp`.

![SCREENSHOT..Part2.docker.cp](screens/Part2.docker.cp.jpg)

Перезапустим **nginx** внутри докер-образа через команду *exec*

![SCREENSHOT..Part2.docker.exec](screens/Part2.docker.exec.jpg)

Проверим, что по адресу *localhost:80/status* отдается страничка со статусом сервера **nginx**

![SCREENSHOT..Part2.status.after.exec](screens/Part2.status.after.exec.jpg)

Экспортируем контейнер в файл *container.tar* через команду *export*

![SCREENSHOT..Part2.docker.export](screens/Part2.docker.export.jpg)

Остановим контейнер

![SCREENSHOT..Part2.docker.stop](screens/Part2.docker.stop.jpg)

Удалим образ через `docker rmi [image_id|repository]`, не удаляя перед этим контейнеры

![SCREENSHOT..Part2.docker.rmi](screens/Part2.docker.rmi.jpg)

Удалим остановленный контейнер

![SCREENSHOT..Part2.docker.rm](screens/Part2.docker.rm.jpg)

Импортируем контейнер обратно через команду *import*

![SCREENSHOT..Part2.docker.import](screens/Part2.docker.import.jpg)

Запустим импортированный контейнер

![SCREENSHOT..Part2.docker.run.after.import](screens/Part2.docker.run.after.import.jpg)

Проверим, что по адресу *localhost:80/status* отдается страничка со статусом сервера **nginx**.

![SCREENSHOT..Part2.status.after.import](screens/Part2.status.after.import.jpg)

