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

with Gtk.Button;
with Gtk.Object;

package Gtk.Toggle_Button is

   type Gtk_Toggle_Button_Record is new Gtk.Button.Gtk_Button_Record
     with private;
   type Gtk_Toggle_Button is access all Gtk_Toggle_Button_Record'Class;

   function Is_Active (Toggle_Button : access Gtk_Toggle_Button_Record)
     return Boolean;
   procedure Gtk_New (Toggle_Button : out Gtk_Toggle_Button;
                      Label         : in String := "");
   procedure Initialize (Toggle_Button : access Gtk_Toggle_Button_Record;
                         Label         : in String := "");
   procedure Set_Mode
     (Toggle_Button  : access Gtk_Toggle_Button_Record;
      Draw_Indicator : in Boolean);
   procedure Set_Active
     (Toggle_Button : access Gtk_Toggle_Button_Record;
      Is_Active     : in Boolean);
   procedure Toggled (Toggle_Button : access Gtk_Toggle_Button_Record);

   --  The two following procedures are used to generate and create widgets
   --  from a Node.

   procedure Generate (N : in Node_Ptr; File : in File_Type);

   procedure Generate
     (Toggle_Button : in out Object.Gtk_Object; N : in Node_Ptr);

private
   type Gtk_Toggle_Button_Record is new Gtk.Button.Gtk_Button_Record
     with null record;

end Gtk.Toggle_Button;
