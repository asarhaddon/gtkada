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
with Gtk.Widget; use Gtk.Widget;

package Gtk.Container is

   type Gtk_Container is new Gtk.Widget.Gtk_Widget with private;

   procedure Add (Container : in out Gtk_Container;
                  Widget       : in Gtk.Widget.Gtk_Widget'Class);

   procedure Border_Width (Container : in Gtk_Container;
                           Border_Width : in Gint);

   procedure Remove (Container : in out Gtk_Container;
                     Widget : in Gtk.Widget.Gtk_Widget'Class);

   procedure Disable_Resize (Container : in out Gtk_Container);

   procedure Enable_Resize (Container : in out Gtk_Container);

   procedure Block_Resize (Container : in out Gtk_Container);

   procedure Unblock_Resize (Container : in out Gtk_Container);

   function Need_Resize (Container : in Gtk_Container) return Boolean;

   procedure Set_Focus_Hadjustment
     (Container  : in out Gtk_Container;
      Adjustment : in     Gtk.Adjustment.Gtk_Adjustment'Class);

   procedure Set_Focus_Vadjustment
     (Container  : in out Gtk_Container;
      Adjustment : in     Gtk.Adjustment.Gtk_Adjustment'Class);

private

   type Gtk_Container is new Gtk.Widget.Gtk_Widget with null record;

end Gtk.Container;
