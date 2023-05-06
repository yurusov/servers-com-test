# Тестовое задание

> Предположим, нам нужна система мониторинга доступности IP-адресов. Напишем небольшое приложение, которое позволит регистрировать и удалять IP-адреса, а также выполнять проверку их доступности, где используя результаты проверки, мы можем выполнить расчет статистики.
> 
> Приложение имеет следующие вызовы:
> 1) добавить IP-адрес к подсчету статистики (параметр - IP-адрес, нотация на твоё усмотрение);
> 2) удалить IP-адрес из подсчета статистики (параметр - IP-адрес, нотация на твоё усмотрение););
> 3) сформировать статистику доступности IP-адреса по ICMP (параметры - IP-адрес, начало интервала времени, конец интервала времени).
> Получив начало и конец интервала времени, должно вернуть JSON, содержащий следующие поля:
> - среднее RTT (время отклика) за этот период;
> - минимальное RTT за этот период;
> - максимальное RTT за этот период;
> - медианное RTT за этот период;
> - среднеквадратичное отклонение замеров RTT за этот период;
> - процент потерянных пакетов ICMP до указанного адреса за этот период.
> 
> Требования к задаче:
> - не использовать rails, за исключением activesupport, Active Record;
> - если проверка доступности занимает более одной секунды, то такая проверка считается неудачной (потеря пакетов) и должна быть прервана;
> - если какую-то часть времени в выбранном периоде IP-адрес был вне расчета статистики (не был добавлен или был удален) — эту часть времени учитывать не нужно. Например, мы добавили IP-адрес 8.8.8.8 в 1 час, выключили в 2, включили в 3 и выключили в 4. Если я запросил статистику с 1 по 4 часа — надо объединить интервалы 1-2, 3-4 и отдать эту статистику по объединенному интервалу. Если IP-адрес не был в расчете статистики всё время или был настолько мало времени, что мы не успели сделать хотя бы 1 замер, – надо вернуть сообщение об ошибке.
> 
> Задания с плюсиком:
> - не использовать activesupport и Active Record;
> - сделать запуск проекта с помощью docker compose;
> - добавить поддержку IPv6 IP-адресов;
> - настроить GitHub Actions (или любой другой CI, зависит от места размещения тестового задания) с запуском тестов.
> 
> Мы хотим посмотреть, как ты:
> - используешь различные библиотеки;
> - работаешь с базой данных без готовых решений;
> - подбираешь стек для хранения и обсчёта статистики;
> - работаешь с требованиями и кодом.
> 
> 