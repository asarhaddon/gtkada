------------------------------------------------------------------------------
--               GtkAda - Ada95 binding for the Gimp Toolkit                --
--                                                                          --
--                     Copyright (C) 1998-2018, AdaCore                     --
--                                                                          --
-- This library is free software;  you can redistribute it and/or modify it --
-- under terms of the  GNU General Public License  as published by the Free --
-- Software  Foundation;  either version 3,  or (at your  option) any later --
-- version. This library is distributed in the hope that it will be useful, --
-- but WITHOUT ANY WARRANTY;  without even the implied warranty of MERCHAN- --
-- TABILITY or FITNESS FOR A PARTICULAR PURPOSE.                            --
--                                                                          --
-- As a special exception under Section 7 of GPL version 3, you are granted --
-- additional permissions described in the GCC Runtime Library Exception,   --
-- version 3.1, as published by the Free Software Foundation.               --
--                                                                          --
-- You should have received a copy of the GNU General Public License and    --
-- a copy of the GCC Runtime Library Exception along with this program;     --
-- see the files COPYING3 and COPYING.RUNTIME respectively.  If not, see    --
-- <http://www.gnu.org/licenses/>.                                          --
--                                                                          --
------------------------------------------------------------------------------

with Glib.Type_Conversion_Hooks;
pragma Elaborate_All (Glib.Type_Conversion_Hooks);
with Gtkada.Handlers;
with Gtk.Widget; use Gtk.Widget;

package body Gtk.GLArea is

   package Type_Conversion is new Glib.Type_Conversion_Hooks.Hook_Registrator
     (Get_Type'Access, Gtk_GLArea_Record);
   pragma Warnings (Off, Type_Conversion);
   --  This package is used to implement a minimal automated type conversion
   --  without having to drag the whole Gtk.Type_Conversion package for the
   --  most common widgets.

   procedure On_Destroy (Widget : access Gtk_Widget_Record'Class);

   ----------------
   -- On_Destroy --
   ----------------

   procedure On_Destroy (Widget : access Gtk_Widget_Record'Class) is
   begin
      --  Temporarily remove widget from its parent, since otherwise we still
      --  get openGL queries after the openGL context has been destroyed,
      --  resulting in a Storage_Error
      Ref (Widget);
      Destroy (Widget);
   end On_Destroy;

   -------------
   -- Gtk_New --
   -------------

   procedure Gtk_New (Widget    : out Gtk_GLArea;
                      Attr_List : Attributes_Array) is
   begin
      Widget := new Gtk_GLArea_Record;
      Initialize (Widget, Attr_List);
   end Gtk_New;

   ----------------
   -- Initialize --
   ----------------

   procedure Initialize (Widget    : access Gtk_GLArea_Record;
                         Attr_List : Attributes_Array)
   is
      function Internal (Attr_List : System.Address) return System.Address;
      pragma Import (C, Internal, "gtk_gl_area_new");
      Attributes : Attributes_Array (0 .. Attr_List'Length);
      use type System.Address;
      S : System.Address;
   begin
      Attributes (0 .. Attr_List'Length - 1) := Attr_List;
      Attributes (Attributes'Last) := Gdk_GL_None;
      S := Internal (Attributes (0)'Address);
      if S = System.Null_Address then
         raise Constraint_Error;
      end if;
      Set_Object (Widget, Internal (Attributes (0)'Address));

      --  gtk+'s double buffering and openGL's don't go together
      Set_Double_Buffered (Widget, False);
      Gtkada.Handlers.Widget_Callback.Connect
         (Widget, "destroy", Gtk.GLArea.On_Destroy'Access);
   end Initialize;

   -------------
   -- Gtk_New --
   -------------

   procedure Gtk_New
     (Widget    : out Gtk_GLArea;
      Attr_List : Attributes_Array;
      Share     : access Gtk_GLArea_Record'Class) is
   begin
      Widget := new Gtk_GLArea_Record;
      Initialize (Widget, Attr_List, Share);
   end Gtk_New;

   ----------------
   -- Initialize --
   ----------------

   procedure Initialize
     (Widget    : access Gtk_GLArea_Record;
      Attr_List : Attributes_Array;
      Share     : access Gtk_GLArea_Record'Class)
   is
      function Internal (Attr_List : System.Address;
                         Share     : System.Address)
                        return System.Address;
      pragma Import (C, Internal, "gtk_gl_area_share_new");
      Attributes : Attributes_Array (0 .. Attr_List'Length);
   begin
      Attributes (0 .. Attr_List'Length - 1) := Attr_List;
      Attributes (Attributes'Last) := Gdk_GL_None;
      Set_Object (Widget, Internal (Attributes (0)'Address,
                                    Get_Object (Share)));

      --  gtk+'s double buffering and openGL's don't go together
      Set_Double_Buffered (Widget, False);
   end Initialize;

   ------------------
   -- Make_Current --
   ------------------

   function Make_Current (Glarea : access Gtk_GLArea_Record'Class)
     return Boolean
   is
      function Internal (GLArea : System.Address) return Gint;
      pragma Import (C, Internal, "gtk_gl_area_make_current");
   begin
      return Boolean'Val (Internal (Get_Object (Glarea)));
   end Make_Current;

   ------------------
   -- Swap_Buffers --
   ------------------

   procedure Swap_Buffers (Glarea : access Gtk_GLArea_Record'Class) is
      procedure Internal (Glarea : System.Address);
      pragma Import (C, Internal, "gtk_gl_area_swap_buffers");
   begin
      Internal (Get_Object (Glarea));
   end Swap_Buffers;

end Gtk.GLArea;
