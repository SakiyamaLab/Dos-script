for i in {1..5};
do
	scp raspi$i:~/Develop/lab/db/Dos-script/*.csv raspi$i/
done
