## Лабораторная работа №2  

*ФИО* - Кожаев Дмитрий Алексеевич  
*Группа* - ББСО - 01 - 18  

**Лабораторная работа состоит из 3-х частей:**  
- *Задание 1:* настройка работоспособной системы с использованием lvm, raid  
- *Задание 2:* эмуляция отказа одного из дисков  
- *Задание 3:* замена дисков на лету, с добавлением новых дисков и переносом разделов  

# Задание 1
1. Устанавливаем и настраиваем новую ОС. Далее начинаем установку Linux и доходим до меню с информацией о дисках.  
![Image alt](https://github.com/kozhaevone/OS/blob/master/lab2/Screenshots/Task1/1.Start%20the%20installation.png)  
2. Создаем таблицу разделов на каждом диске и выделяем место для /boot размером 512М.    
![Image alt](https://github.com/kozhaevone/OS/blob/master/lab2/Screenshots/Task1/2.Rzdelenie_diskov.png)
3. Указали место для RAID.  
![Image alt](https://github.com/kozhaevone/OS/blob/master/lab2/Screenshots/Task1/3.memory.png)  
4. Настраиваем RAID.
![Image alt](https://github.com/kozhaevone/OS/blob/master/lab2/Screenshots/Task1/4.RAID.png)  
5. Далее начинаем настройку LWM и создаём группу томов.  
![Image alt](https://github.com/kozhaevone/OS/blob/master/lab2/Screenshots/Task1/5.LWM.png)  
![Image alt](https://github.com/kozhaevone/OS/blob/master/lab2/Screenshots/Task1/6.LWM_step2.png)  
6. Для каждого тома сделали соответствующие им точки монтирования и завершили настройку LWM.  
![Image alt](https://github.com/kozhaevone/OS/blob/master/lab2/Screenshots/Task1/7.Finish_LWM.PNG)  
7. После "разметки дисков" устанавливаем GRUB на 1 устройство sda и загружаем систему.  
![Image alt](https://github.com/kozhaevone/OS/blob/master/lab2/Screenshots/Task1/9.Grub_disk1.PNG)  
8. Выполнили копирование содержимого раздела /boot с диска sda(ssd1) на диск sdb(ssd2). Посмотрели информацию о дисках с помощью команд:  
- **fdisk -l** - смотрим имеющиеся диски и разделы;
- **lsblk -o NAME,SIZE,FSTYPE,TYPE,MOUNTPOINT** - команда показывает: название дисков и разделов, тип файловой системы, размер всего диска и каждого раздела, а также точки монтирования.  
![Image alt](https://github.com/kozhaevone/OS/blob/master/lab2/Screenshots/Task1/13.fdisk-l.png)  
![Image alt](https://github.com/kozhaevone/OS/blob/master/lab2/Screenshots/Task1/10.inf_fisk.png)  
9. Посмотрели информацию о текущем RAID с помощью команды:  
- **cat /proc/mdstat** - показывает информацию о текущем RAID;  
![Image alt](https://github.com/kozhaevone/OS/blob/master/lab2/Screenshots/Task1/11.inf_RAID.png)  
10. Посмотрели выводы с помощью команд:  
- **pvs** - отображение физических томов;
- **lvs** - вывод информации о logical volume;  
- **vgs** - отображение volume group, информация об этих группах;  
![Image alt](https://github.com/kozhaevone/OS/blob/master/lab2/Screenshots/Task1/12.inf_dop.PNG)  

# Задание 2  
1. В процессе работы у нас отказывает один ssd, и нам требуется восстановить все его данные. При проверке ВМ на работоспособность после отключения SSD мы можем увидеть, что, действительно, остался только один диск.  
![Image alt](https://github.com/kozhaevone/OS/blob/master/lab2/Screenshots/Task2/1.ssd_upal.png)  
2. Проверим статус RAID-массива с помощью команды: cat /proc/mdstat  
![Image alt](https://github.com/kozhaevone/OS/blob/master/lab2/Screenshots/Task2/2.status_RAID.png)  
