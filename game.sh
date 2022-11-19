# game.sh

#!/usr/bin/bash

win=false
turn=1
p_1="X"
p_2="O"
board=( "#" "#" "#" "#" "#" "#" "#" "#" "#" )

beg_message ()
{
clear
echo "=== TICK TACK TOE ==="
echo "Chose square by selecting position"
echo "0 1 2"
echo "3 4 5"
echo "6 7 8"
echo "====================="
}

draw_board ()
{
echo "${board[0]} ${board[1]} ${board[2]}"
echo "${board[3]} ${board[4]} ${board[5]}"
echo "${board[6]} ${board[7]} ${board[8]}"
}

check_who_won ()
{
if [[ ${board[$1]} == "X" ]]
then
  echo "Player 1 won"
else
  echo "Player 2 won"
fi
}

check_if_win ()
{
if  [[ ${board[0]}  == ${board[1]} ]] && [[ ${board[1]}  ==  ${board[2]} ]] && [[ ${board[0]} != "#" ]]
then
  win=true
  check_who_won 0
elif  [[ ${board[3]}  == ${board[4]} ]] && [[ ${board[4]}  ==  ${board[5]} ]] && [[ ${board[3]} != "#" ]]
then
  win=true
  check_who_won 3
elif  [[ ${board[6]}  == ${board[7]} ]] && [[ ${board[7]}  ==  ${board[8]} ]] && [[ ${board[6]} != "#" ]]
then
  win=true
  check_who_won 6
elif  [[ ${board[0]}  == ${board[3]} ]] && [[ ${board[3]}  ==  ${board[6]} ]] && [[ ${board[0]} != "#" ]]
then
  win=true
  check_who_won 0
elif  [[ ${board[1]}  == ${board[4]} ]] && [[ ${board[4]}  ==  ${board[7]} ]] && [[ ${board[1]} != "#" ]]
then
  win=true
  check_who_won 1
elif  [[ ${board[2]}  == ${board[5]} ]] && [[ ${board[5]}  ==  ${board[8]} ]] && [[ ${board[2]} != "#" ]]
then
  win=true
  check_who_won 2
elif  [[ ${board[0]}  == ${board[4]} ]] && [[ ${board[4]}  ==  ${board[8]} ]] && [[ ${board[0]} != "#" ]]
then
  win=true
  check_who_won 0
elif  [[ ${board[2]}  == ${board[4]} ]] && [[ ${board[4]}  ==  ${board[6]} ]] && [[ ${board[2]} != "#" ]]
then
  win=true
  check_who_won 2
fi
}

player_turn ()
{
if [[ $(($turn % 2)) == 1 ]]
then
  echo "Player 1 chooses"
  p=$p_1
else
  echo "Player 2 chooses"
  p=$p_2
fi
read pos
if  [[ "$pos" =~ ^[0-8]{1}$ ]]
then
  if [[ ${board[$pos]} == "X" ]] || [[ ${board[$pos]} == "O" ]] 
  then
    echo "Choose right position"
    player_turn
  else
    board[$pos]=$p
    draw_board
    turn=$((turn+1))
    check_if_win
    if [[ $win == true  ]]
    then
      echo "The game has ended"
    elif [[ $turn == 10 ]]
    then
      echo "Draw. The game has ended"
    else
      player_turn
    fi
  fi
else
  echo "Choose right position"
  player_turn
fi
}

beg_message
draw_board
player_turn