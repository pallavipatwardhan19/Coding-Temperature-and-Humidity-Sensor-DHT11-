org 0000H
sjmp main
org 0040H
main:setb P2.2
     clr P2.2
     acall delay1      ;delay of 18us for uC's start signal
     setb P2.2
wait:jb P2.2,wait      ;wait until DHT11 pulls down the signal
wait1:jnb P2.2,wait1   ;wait for the low signal of DHT11 response pulse
wait2:jb P2.2,wait2    ;wait for the high signal of DHT11 response pulse
wait3:jnb P2.2,wait3   ;50uS low pulse before data transmission
start:mov tmod,#10H    ;configure timer 1 in tmod register
      clr tf1
      setb tr1	       ;start timer 1
wait4:jb P2.2, wait4   ;wait until the pulse is high
loop: clr tr1	       ;now the width of the pulse is stored in tl1
      mov a,tl1
      subb a,#32H      ;subtract content of tl1 with 50uS
      jc less	       ;if carry is generated, then the width of the pulse is less than 50uS, eles it is greater than 50uS 
