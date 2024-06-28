for i in {1..5};
do
	scp raspi$i:~/Develop/lab/db/Dos-script/*$1*$2*.csv raspi$i/
done
