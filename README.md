# RDA5981A SDK TEST + Visual Studio Makefile Project

Минималистичный SDK + проект на основе официальной версии v1.3.5.<br>

Статья-обзор на модуль и краткое описание проекта - [Обзор модуля RDA5981X1](https://adelectronics.ru/2018/03/04/обзор-модуля-rda5981x1/<br>

Особенности:<br>
* Вырезаны все .py тулсы по сборке с помощью mbed.<br>
* Все примеры собраны в папке demo.<br>
* Вырезан весь мусор, не относящийся к сборке с помощью Makefile.<br>
* Добавлен пример Makefile для сборки проекта с помощью [GNU Arm Embedded Toolchain](https://developer.arm.com/open-source/gnu-toolchain/gnu-rm/downloads).<br>
* Добавлен простой пример проекта в Visual Studio 2015, общее описание для другого SoC можно посмотреть [тут](https://adelectronics.ru/2017/10/18/rtl8195am-rtl871xax-%d0%bd%d0%b0%d0%bf%d0%b8%d1%81%d0%b0%d0%bd%d0%b8%d0%b5-%d0%bf%d1%80%d0%be%d1%88%d0%b8%d0%b2%d0%ba%d0%b8-%d0%b8-%d0%be%d1%82%d0%bb%d0%b0%d0%b4%d0%ba%d0%b0-%d0%b2-visual-studio-20/)<br>

Будет добавлено позже:<br>
* Исправить компиляцию, она пока возможна только в 1 поток (-j 1).<br>
* Инструменты для отладки с помощью J-Link.<br>
