import pi_servo_hat
import time
import curses
import os

def main(win):
  limlo = -44
  limhi = 140
  delta = 1

  x = 64
  y = 7

  key = ""

  servo = pi_servo_hat.PiServoHat()
  servo.restart()

  win.nodelay(True)

  servo.move_servo_position(1, x)
  servo.move_servo_position(0, y)

  while True:
    try:
      key = win.getkey()
    except Exception as e:
      key = ""
      pass

    if key != "":
      if key == os.linesep:
        break

      if key == "KEY_LEFT":
        x = max(limlo, x - delta)
      if key == "KEY_RIGHT":
        x = min(limhi, x + delta)
      if key == "KEY_UP":
        y = min(limhi, y + delta)
      if key == "KEY_DOWN":
        y = max(limlo, y - delta)

      win.clear()
      win.addstr(str(x) + " " + str(y))

      servo.move_servo_position(1, x)
      servo.move_servo_position(0, y)

curses.wrapper(main)
