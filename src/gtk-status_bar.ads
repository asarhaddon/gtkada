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
with Gtk.Box;
with Interfaces.C.Strings;
with Glib.GSlist;
with System;

package Gtk.Status_Bar is

   type Gtk_Status_Bar_Record is new Gtk.Box.Gtk_Box_Record with private;
   type Gtk_Status_Bar is access all Gtk_Status_Bar_Record'Class;

   subtype Gtk_Statusbar is Gtk_Status_Bar;
   --  This is needed by Gate since the C name is GtkStatusbar

   type Context_Id is new Guint;
   type Message_Id is new Guint;

   type Status_Bar_Msg is record
      Text    : Interfaces.C.Strings.chars_ptr;
      Context : Context_Id;
      Message : Message_Id;
   end record;

   function Convert (Msg : Status_Bar_Msg) return System.Address;
   function Convert (Msg : System.Address) return Status_Bar_Msg;
   package Messages_List is new Glib.GSlist.Generic_SList (Status_Bar_Msg);

   procedure Gtk_New (Statusbar : out Gtk_Status_Bar);
   procedure Initialize (Statusbar : access Gtk_Status_Bar_Record'Class);

   function Get_Context_Id (Statusbar           : access Gtk_Status_Bar_Record;
                            Context_Description : in String)
                            return Context_Id;

   function Get_Messages (Statusbar : access Gtk_Status_Bar_Record)
                          return Messages_List.GSlist;

   function Push
     (Statusbar : access Gtk_Status_Bar_Record;
      Context   : in Context_Id;
      Text      : in String)
      return Message_Id;

   procedure Pop
     (Statusbar : access Gtk_Status_Bar_Record;
      Context   : in Context_Id);

   procedure Remove (Statusbar  : access Gtk_Status_Bar_Record;
                     Context    : in Context_Id;
                     Message    : in Message_Id);

   --  The following two procedures are used to generate and create widgets
   --  from a Node.

   procedure Generate (N         : in Node_Ptr;
                       File      : in File_Type);

   procedure Generate (Statusbar : in out Gtk_Object;
                       N         : in Node_Ptr);

private
   type Gtk_Status_Bar_Record is new Gtk.Box.Gtk_Box_Record with null record;

end Gtk.Status_Bar;
