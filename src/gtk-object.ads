-----------------------------------------------------------------------
--          GtkAda - Ada95 binding for the Gimp Toolkit              --
--                                                                   --
-- Copyright (C) 1998 Emmanuel Briot and Joel Brobecker              --
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

with Gdk; use Gdk;

package Gtk.Object is

   type Gtk_Object is new Root_Type with private;

   procedure Destroy (Object : in out Gtk_Object);

   function Get_Type (Object : in Gtk_Object) return Gint;

   procedure Ref (Object : in out Gtk_Object);

   procedure Unref (Object : in out Gtk_Object);

   ---------------
   -- User_Data --
   ---------------

   generic
      type Data_Type (<>) is private;
   package User_Data is
      function Get (Object : in Gtk_Object'Class;
                    Id     : in String := "user_data") return Data_Type;

      procedure Set (Object : in Gtk_Object'Class;
                     Data   : in Data_Type;
                     Id     : in String := "user_data");
   end User_Data;

   --  The previous package implements the User_Data stuff.
   --  !! Warning !! No type verification is made to check if you are
   --  using the appropriate function Get. This is your own responsability

   -------------
   --  Flags  --
   -------------

   function Flags (Object : in Gtk_Object) return Guint32;

   procedure Set_Flags (Object : in out Gtk_Object;
                        Flags  : in     Guint32);

   procedure Unset_Flags (Object : in out Gtk_Object;
                          Flags  : in     Guint32);


   function Destroyed (Object : in Gtk_Object) return Boolean;

   function Floating (Object : in Gtk_Object) return Boolean;

   function Connected (Object : in Gtk_Object) return Boolean;

private
   type Gtk_Object is new Root_Type with null record;

end Gtk.Object;
