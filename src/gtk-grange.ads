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

with Gtk.Adjustment;
with Gtk.Enums; use Gtk.Enums;
with Gtk.Widget;

package Gtk.GRange is

   type Gtk_Range is new Gtk.Widget.Gtk_Widget with private;

   procedure Default_Hmotion
      (The_Range : in Gtk_Range;
       Xdelta    : in Gint;
       Ydelta    : in Gint);
   procedure Default_Hslider_Update (The_Range : in Gtk_Range);

   procedure Default_Htrough_Click
     (The_Range : in Gtk_Range;
      X         : in Gint;
      Y         : in Gint;
      Jump_Perc : in out Gfloat;
      Result    : out Gint);
   --  Was a function in C

   procedure Default_Vmotion
      (The_Range : in Gtk_Range;
       Xdelta    : in Gint;
       Ydelta    : in Gint);
   procedure Default_Vslider_Update (The_Range : in Gtk_Range);

   procedure Default_Vtrough_Click
      (The_Range : in Gtk_Range;
       X         : in Gint;
       Y         : in Gint;
       Jump_Perc : in out Gfloat;
       Result    :    out Gint);
   --  Was a function in C

   procedure Draw_Background (The_Range : in Gtk_Range);
   procedure Draw_Slider (The_Range : in Gtk_Range);
   procedure Draw_Step_Back (The_Range : in Gtk_Range);
   procedure Draw_Step_Forw (The_Range : in Gtk_Range);
   procedure Draw_Trough (The_Range : in Gtk_Range);
   function Get_Adjustment (The_Range  : in Gtk_Range)
                            return      Gtk.Adjustment.Gtk_Adjustment'Class;
   procedure Set_Adjustment
      (The_Range  : in Gtk_Range;
       Adjustment : in Gtk.Adjustment.Gtk_Adjustment'Class);
   procedure Set_Update_Policy
      (The_Range : in Gtk_Range;
       Policy    : in Gtk_Update_Type);
   procedure Slider_Update (The_Range : in Gtk_Range);

   procedure Trough_Click
      (The_Range : in Gtk_Range;
       X         : in Gint;
       Y         : in Gint;
       Jump_Perc : in out Gfloat;
       Result    :    out Gint);
   --  Was a function in C

private
   type Gtk_Range is new Gtk.Widget.Gtk_Widget with null record;

end Gtk.GRange;
