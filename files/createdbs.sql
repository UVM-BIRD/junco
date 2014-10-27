create database junco_dev;
create database junco_test;

grant all on junco_dev.* to 'junco'@'localhost' identified by 'junco';
grant all on junco_test.* to 'junco'@'localhost' identified by 'junco';
