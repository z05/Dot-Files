#!/usr/bin/python2
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

import os
import subprocess
import gtk

class Caritastray:
  def __init__(self):
    self.status_icon = gtk.StatusIcon()
    self.status_icon.set_from_file("~/.config/wmfs/wmfs_img/ghost.png")
    self.status_icon.set_visible(True)
    self.status_icon.set_tooltip("Caritas Tray - By Shaggy")
    self.status_icon.connect("activate", self.on_left_click)
    self.status_icon.connect("popup-menu", self.on_right_click)
    gtk.main()

  def on_execute(self, widget, event, data):
    subprocess.Popen(self.commands[data], shell=True)

  def on_quit(self, widget, event):
    gtk.main_quit()

  def on_left_click(self, event):
    with open(os.path.expanduser("~/.caritastray"), "r") as caritasconfigfile:
      lines = caritasconfigfile.readlines()
    caritasconfigfile.close()
    i = 0
    self.names = []
    self.commands = {}
    for caritasconfigline in lines:
      caritasconfigline = caritasconfigline.strip()
      if caritasconfigline[:3] == "i: ":
        i += 1
        do_include = False
      if caritasconfigline[:3] == "c: " and caritasconfigline[3:7] != "ctray":
        self.commands[i] = caritasconfigline[3:]
        do_include = True
      if caritasconfigline[:3] == "t: " and do_include:
        self.names.append((caritasconfigline[3:],i))
    main_menu = gtk.Menu()
    for ctray_entry in self.names:
      main_menu_item = gtk.MenuItem(ctray_entry[0])
      main_menu_item.connect("activate", self.on_execute, self.status_icon, ctray_entry[1])
      main_menu.append(main_menu_item)
    main_menu.show_all()
    main_menu.popup(None, None, gtk.status_icon_position_menu, 1, gtk.get_current_event_time(), self.status_icon)

  def on_right_click(self, button, time, data):
    quit_menu = gtk.Menu()
    quit_menu_item = gtk.MenuItem("Quit")
    quit_menu_item.connect("activate", self.on_quit, self.status_icon)
    quit_menu.append(quit_menu_item)
    quit_menu.show_all()
    quit_menu.popup(None, None, gtk.status_icon_position_menu, 1, gtk.get_current_event_time(), self.status_icon)
    
if __name__ == "__main__":
  caritastray = Caritastray()

