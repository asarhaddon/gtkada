-----------------------------------------------------------------------
--          GtkAda - Ada95 binding for the Gimp Toolkit              --
--                                                                   --
--                     Copyright (C) 1998-1999                       --
--        Emmanuel Briot, Joel Brobecker and Arnaud Charlet          --
--                                                                   --
-- This library is free software; you can redistribute it and/or     --
-- modify it under the terms of the GNU General Public               --
-- License as published by the Free Software Foundation; either      --
-- version 2 of the License, or (at your option) any later version.  --
--                                                                   --
-- This library is distributed in the hope that it will be useful,   --
-- but WITHOUT ANY WARRANTY; without even the implied warranty of    --
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU --
-- General Public License for more details.                          --
--                                                                   --
-- You should have received a copy of the GNU General Public         --
-- License along with this library; if not, write to the             --
-- Free Software Foundation, Inc., 59 Temple Place - Suite 330,      --
-- Boston, MA 02111-1307, USA.                                       --
--                                                                   --
-- As a special exception, if other files instantiate generics from  --
-- this unit, or you link this unit with other files to produce an   --
-- executable, this  unit  does not  by itself cause  the resulting  --
-- executable to be covered by the GNU General Public License. This  --
-- exception does not however invalidate any other reasons why the   --
-- executable file  might be covered by the  GNU Public License.     --
-----------------------------------------------------------------------

with Gtk.Object; use Gtk.Object;
with Gtk.Bin;
with Gtk.Enums;

package Gtk.Button is

   type Gtk_Button_Record is new Bin.Gtk_Bin_Record with private;
   type Gtk_Button is access all Gtk_Button_Record'Class;

   procedure Gtk_New (Button : out Gtk_Button; Label : in String := "");

   procedure Initialize (Button : access Gtk_Button_Record'Class;
                         Label : in String);

   procedure Set_Relief (Button   : access Gtk_Button_Record;
                         NewStyle : in     Gtk.Enums.Gtk_Relief_Style);
   function Get_Relief (Button : access Gtk_Button_Record)
                        return Gtk.Enums.Gtk_Relief_Style;

   --  The two following procedures are used to generate and create widgets
   --  from a Node.

   procedure Generate (N      : in Node_Ptr;
                       File   : in File_Type);

   procedure Generate (Button : in out Gtk_Object; N : in Node_Ptr);

   ---------------
   --  Signals  --
   ---------------

   --  The following functions send signals to the widget.

   procedure Pressed  (Button : access Gtk_Button_Record);
   procedure Released (Button : access Gtk_Button_Record);
   procedure Clicked  (Button : access Gtk_Button_Record);
   procedure Enter    (Button : access Gtk_Button_Record);
   procedure Leave    (Button : access Gtk_Button_Record);

private

   type Gtk_Button_Record is new Bin.Gtk_Bin_Record
     with null record;

end Gtk.Button;
