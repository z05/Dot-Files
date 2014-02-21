#!/bin/bash

RXB=$(cat /sys/class/net/wlan0/statistics/rx_bytes)
TXB=$(cat /sys/class/net/wlan0/statistics/tx_bytes)
sleep 2
RXBN=$(cat /sys/class/net/wlan0/statistics/rx_bytes)
TXBN=$(cat /sys/class/net/wlan0/statistics/tx_bytes)
RXDIF=$(echo $((RXBN - RXB)) )
TXDIF=$(echo $((TXBN - TXB)) )

echo "$((TXDIF / 1024 / 2))k/s $((RXDIF / 1024 / 2))k/s"
