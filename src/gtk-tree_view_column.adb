-----------------------------------------------------------------------
--              GtkAda - Ada95 binding for Gtk+/Gnome                --
--                                                                   --
--                     Copyright (C) 2001                            --
--                         ACT-Europe                                --
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

with Gdk.Rectangle;
with Gdk.Window;
with Gdk; use Gdk;
with Gtk.Cell_Renderer;
with Gtk.Enums; use Gtk.Enums;
with Gtk.Tree_Model;
with Gtk.Widget;
with Gtk.Widget; use Gtk.Widget;
with Gtk; use Gtk;
with System;

package body Gtk.Tree_View_Column is

   -------------
   -- Gtk_New --
   -------------

   procedure Gtk_New (Widget : out Gtk_Tree_View_Column)
   is
   begin
      Widget := new Gtk_Tree_View_Column_Record;
      Gtk.Tree_View_Column.Initialize (Widget);
   end Gtk_New;

   ----------------
   -- Initialize --
   ----------------

   procedure Initialize (Widget : access Gtk_Tree_View_Column_Record'Class)
   is
      function Internal return System.Address;
      pragma Import (C, Internal, "gtk_tree_view_column_new");
   begin
      Set_Object (Widget, Internal);
      Initialize_User_Data (Widget);
   end Initialize;

   ----------------
   -- Pack_Start --
   ----------------

   procedure Pack_Start
     (Tree_Column : access Gtk_Tree_View_Column_Record;
      Cell        : access Gtk.Cell_Renderer.Gtk_Cell_Renderer_Record'Class;
      Expand      : Boolean)
   is
      procedure Internal
        (Tree_Column : System.Address;
         Cell        : System.Address;
         Expand      : Gint);
      pragma Import (C, Internal, "gtk_tree_view_column_pack_start");
   begin
      Internal (Get_Object (Tree_Column),
                Get_Object (Cell),
                Boolean'Pos (Expand));
   end Pack_Start;

   --------------
   -- Pack_End --
   --------------

   procedure Pack_End
     (Tree_Column : access Gtk_Tree_View_Column_Record;
      Cell        : access Gtk.Cell_Renderer.Gtk_Cell_Renderer_Record'Class;
      Expand      : Boolean)
   is
      procedure Internal
        (Tree_Column : System.Address;
         Cell        : System.Address;
         Expand      : Gint);
      pragma Import (C, Internal, "gtk_tree_view_column_pack_end");
   begin
      Internal (Get_Object (Tree_Column),
                Get_Object (Cell),
                Boolean'Pos (Expand));
   end Pack_End;

   -----------
   -- Clear --
   -----------

   procedure Clear (Tree_Column : access Gtk_Tree_View_Column_Record)
   is
      procedure Internal (Tree_Column : System.Address);
      pragma Import (C, Internal, "gtk_tree_view_column_clear");
   begin
      Internal (Get_Object (Tree_Column));
   end Clear;

   ------------------------
   -- Get_Cell_Renderers --
   ------------------------

   function Get_Cell_Renderers
     (Tree_Column : access Gtk_Tree_View_Column_Record)
     return Gtk.Cell_Renderer.Cell_Renderer_List.Glist
   is
      function Internal (Tree_Column : System.Address)
                         return System.Address;
      pragma Import (C, Internal, "gtk_tree_view_column_get_cell_renderers");
      List : Gtk.Cell_Renderer.Cell_Renderer_List.Glist;
   begin
      Gtk.Cell_Renderer.Cell_Renderer_List.Set_Object
        (List, Internal (Get_Object (Tree_Column)));
      return List;
   end Get_Cell_Renderers;

   -------------------
   -- Add_Attribute --
   -------------------

   procedure Add_Attribute
     (Tree_Column   : access Gtk_Tree_View_Column_Record;
      Cell_Renderer : access Gtk.Cell_Renderer.Gtk_Cell_Renderer_Record'Class;
      Attribute     : String;
      Column        : Gint)
   is
      procedure Internal
        (Tree_Column   : System.Address;
         Cell_Renderer : System.Address;
         Attribute     : String;
         Column        : Gint);
      pragma Import (C, Internal, "gtk_tree_view_column_add_attribute");
   begin
      Internal (Get_Object (Tree_Column),
                Get_Object (Cell_Renderer),
                Attribute & ASCII.NUL,
                Column);
   end Add_Attribute;

   --    ------------------------
   --    -- Set_Cell_Data_Func --
   --    ------------------------

   --    procedure Set_Cell_Data_Func
   --      (Tree_Column   : access Gtk_Tree_View_Column_Record;
   --       Cell_Renderer :
   --         access Gtk.Cell_Renderer.Gtk_Cell_Renderer_Record'Class;
   --       Func          : Gtk_Tree_Cell_Data_Func;
   --       Func_Data     : gpointer;
   --       Destroy       : Gtk_Destroy_Notify)
   --    is
   --       procedure Internal
   --         (Tree_Column   : System.Address;
   --          Cell_Renderer : System.Address;
   --          Func          : Gint;
   --          Func_Data     : Integer;
   --          Destroy       : Gint);
   --       pragma Import
   --                (C, Internal, "gtk_tree_view_column_set_cell_data_func");
   --    begin
   --       Internal (Get_Object (Tree_Column),
   --                 Get_Object (Cell_Renderer),
   --                 Gtk_Tree_Cell_Data_Func'Pos (Func),
   --                 Func_Data,
   --                 Gtk_Destroy_Notify'Pos (Destroy));
   --    end Set_Cell_Data_Func;

   ----------------------
   -- Clear_Attributes --
   ----------------------

   procedure Clear_Attributes
     (Tree_Column   : access Gtk_Tree_View_Column_Record;
      Cell_Renderer : access Gtk.Cell_Renderer.Gtk_Cell_Renderer_Record'Class)
   is
      procedure Internal
        (Tree_Column   : System.Address;
         Cell_Renderer : System.Address);
      pragma Import (C, Internal, "gtk_tree_view_column_clear_attributes");
   begin
      Internal (Get_Object (Tree_Column),
                Get_Object (Cell_Renderer));
   end Clear_Attributes;

   -----------------
   -- Set_Spacing --
   -----------------

   procedure Set_Spacing
     (Tree_Column : access Gtk_Tree_View_Column_Record;
      Spacing     : Gint)
   is
      procedure Internal
        (Tree_Column : System.Address;
         Spacing     : Gint);
      pragma Import (C, Internal, "gtk_tree_view_column_set_spacing");
   begin
      Internal (Get_Object (Tree_Column),
                Spacing);
   end Set_Spacing;

   -----------------
   -- Get_Spacing --
   -----------------

   function Get_Spacing (Tree_Column : access Gtk_Tree_View_Column_Record)
                        return Gint
   is
      function Internal (Tree_Column : System.Address)
                        return Gint;
      pragma Import (C, Internal, "gtk_tree_view_column_get_spacing");
   begin
      return Internal (Get_Object (Tree_Column));
   end Get_Spacing;

   -----------------
   -- Set_Visible --
   -----------------

   procedure Set_Visible
     (Tree_Column : access Gtk_Tree_View_Column_Record;
      Visible     : Boolean)
   is
      procedure Internal
        (Tree_Column : System.Address;
         Visible     : Gint);
      pragma Import (C, Internal, "gtk_tree_view_column_set_visible");
   begin
      Internal (Get_Object (Tree_Column),
                Boolean'Pos (Visible));
   end Set_Visible;

   -----------------
   -- Get_Visible --
   -----------------

   function Get_Visible (Tree_Column : access Gtk_Tree_View_Column_Record)
                        return Boolean
   is
      function Internal (Tree_Column : System.Address)
                        return Gint;
      pragma Import (C, Internal, "gtk_tree_view_column_get_visible");
   begin
      return Boolean'Val (Internal (Get_Object (Tree_Column)));
   end Get_Visible;

   ----------------
   -- Set_Sizing --
   ----------------

   procedure Set_Sizing
     (Tree_Column : access Gtk_Tree_View_Column_Record;
      The_Type    : Gtk_Tree_View_Column_Sizing)
   is
      procedure Internal
        (Tree_Column : System.Address;
         The_Type    : Gint);
      pragma Import (C, Internal, "gtk_tree_view_column_set_sizing");
   begin
      Internal (Get_Object (Tree_Column),
                Gtk_Tree_View_Column_Sizing'Pos (The_Type));
   end Set_Sizing;

   ----------------
   -- Get_Sizing --
   ----------------

   function Get_Sizing (Tree_Column : access Gtk_Tree_View_Column_Record)
                       return Gtk_Tree_View_Column_Sizing
   is
      function Internal (Tree_Column : System.Address)
                        return Gint;
      pragma Import (C, Internal, "gtk_tree_view_column_get_sizing");
   begin
      return Gtk_Tree_View_Column_Sizing'Val
        (Internal (Get_Object (Tree_Column)));
   end Get_Sizing;

   ---------------
   -- Get_Width --
   ---------------

   function Get_Width (Tree_Column : access Gtk_Tree_View_Column_Record)
                      return Gint
   is
      function Internal (Tree_Column : System.Address)
                        return Gint;
      pragma Import (C, Internal, "gtk_tree_view_column_get_width");
   begin
      return Internal (Get_Object (Tree_Column));
   end Get_Width;

   ---------------------
   -- Get_Fixed_Width --
   ---------------------

   function Get_Fixed_Width (Tree_Column : access Gtk_Tree_View_Column_Record)
                            return Gint
   is
      function Internal (Tree_Column : System.Address)
                        return Gint;
      pragma Import (C, Internal, "gtk_tree_view_column_get_fixed_width");
   begin
      return Internal (Get_Object (Tree_Column));
   end Get_Fixed_Width;

   ---------------------
   -- Set_Fixed_Width --
   ---------------------

   procedure Set_Fixed_Width
     (Tree_Column : access Gtk_Tree_View_Column_Record;
      Fixed_Width : Gint)
   is
      procedure Internal
        (Tree_Column : System.Address;
         Fixed_Width : Gint);
      pragma Import (C, Internal, "gtk_tree_view_column_set_fixed_width");
   begin
      Internal (Get_Object (Tree_Column),
                Fixed_Width);
   end Set_Fixed_Width;

   -------------------
   -- Set_Min_Width --
   -------------------

   procedure Set_Min_Width
     (Tree_Column : access Gtk_Tree_View_Column_Record;
      Min_Width   : Gint)
   is
      procedure Internal
        (Tree_Column : System.Address;
         Min_Width   : Gint);
      pragma Import (C, Internal, "gtk_tree_view_column_set_min_width");
   begin
      Internal (Get_Object (Tree_Column),
                Min_Width);
   end Set_Min_Width;

   -------------------
   -- Get_Min_Width --
   -------------------

   function Get_Min_Width (Tree_Column : access Gtk_Tree_View_Column_Record)
                          return Gint
   is
      function Internal (Tree_Column : System.Address)
                        return Gint;
      pragma Import (C, Internal, "gtk_tree_view_column_get_min_width");
   begin
      return Internal (Get_Object (Tree_Column));
   end Get_Min_Width;

   -------------------
   -- Set_Max_Width --
   -------------------

   procedure Set_Max_Width
     (Tree_Column : access Gtk_Tree_View_Column_Record;
      Max_Width   : Gint)
   is
      procedure Internal
        (Tree_Column : System.Address;
         Max_Width   : Gint);
      pragma Import (C, Internal, "gtk_tree_view_column_set_max_width");
   begin
      Internal (Get_Object (Tree_Column),
                Max_Width);
   end Set_Max_Width;

   -------------------
   -- Get_Max_Width --
   -------------------

   function Get_Max_Width (Tree_Column : access Gtk_Tree_View_Column_Record)
                          return Gint
   is
      function Internal (Tree_Column : System.Address)
                        return Gint;
      pragma Import (C, Internal, "gtk_tree_view_column_get_max_width");
   begin
      return Internal (Get_Object (Tree_Column));
   end Get_Max_Width;

   -------------
   -- Clicked --
   -------------

   procedure Clicked (Tree_Column : access Gtk_Tree_View_Column_Record)
   is
      procedure Internal (Tree_Column : System.Address);
      pragma Import (C, Internal, "gtk_tree_view_column_clicked");
   begin
      Internal (Get_Object (Tree_Column));
   end Clicked;

   ---------------
   -- Set_Title --
   ---------------

   procedure Set_Title
     (Tree_Column : access Gtk_Tree_View_Column_Record;
      Title       : String)
   is
      procedure Internal
        (Tree_Column : System.Address;
         Title       : String);
      pragma Import (C, Internal, "gtk_tree_view_column_set_title");
   begin
      Internal (Get_Object (Tree_Column),
                Title & ASCII.NUL);
   end Set_Title;

   -------------------
   -- Set_Clickable --
   -------------------

   procedure Set_Clickable
     (Tree_Column : access Gtk_Tree_View_Column_Record;
      Clickable   : Boolean)
   is
      procedure Internal
        (Tree_Column : System.Address;
         Clickable   : Gint);
      pragma Import (C, Internal, "gtk_tree_view_column_set_clickable");
   begin
      Internal (Get_Object (Tree_Column),
                Boolean'Pos (Clickable));
   end Set_Clickable;

   -------------------
   -- Get_Clickable --
   -------------------

   function Get_Clickable (Tree_Column : access Gtk_Tree_View_Column_Record)
                          return Boolean
   is
      function Internal (Tree_Column : System.Address)
                        return Gint;
      pragma Import (C, Internal, "gtk_tree_view_column_get_clickable");
   begin
      return Boolean'Val (Internal (Get_Object (Tree_Column)));
   end Get_Clickable;

   ----------------
   -- Set_Widget --
   ----------------

   procedure Set_Widget
     (Tree_Column : access Gtk_Tree_View_Column_Record;
      Widget      : access Gtk.Widget.Gtk_Widget_Record'Class)
   is
      procedure Internal
        (Tree_Column : System.Address;
         Widget      : System.Address);
      pragma Import (C, Internal, "gtk_tree_view_column_set_widget");
   begin
      Internal (Get_Object (Tree_Column),
                Get_Object (Widget));
   end Set_Widget;

   ----------------
   -- Get_Widget --
   ----------------

   function Get_Widget (Tree_Column : access Gtk_Tree_View_Column_Record)
                       return Gtk.Widget.Gtk_Widget
   is
      function Internal (Tree_Column : System.Address)
                        return System.Address;
      pragma Import (C, Internal, "gtk_tree_view_column_get_widget");
   begin
      return Widget.Convert (Internal (Get_Object (Tree_Column)));
   end Get_Widget;

   -------------------
   -- Set_Alignment --
   -------------------

   procedure Set_Alignment
     (Tree_Column : access Gtk_Tree_View_Column_Record;
      Xalign      : Gfloat)
   is
      procedure Internal
        (Tree_Column : System.Address;
         Xalign      : Gfloat);
      pragma Import (C, Internal, "gtk_tree_view_column_set_alignment");
   begin
      Internal (Get_Object (Tree_Column),
                Xalign);
   end Set_Alignment;

   -------------------
   -- Get_Alignment --
   -------------------

   function Get_Alignment (Tree_Column : access Gtk_Tree_View_Column_Record)
                          return Gfloat
   is
      function Internal (Tree_Column : System.Address)
                        return Gfloat;
      pragma Import (C, Internal, "gtk_tree_view_column_get_alignment");
   begin
      return Internal (Get_Object (Tree_Column));
   end Get_Alignment;

   ---------------------
   -- Set_Reorderable --
   ---------------------

   procedure Set_Reorderable
     (Tree_Column : access Gtk_Tree_View_Column_Record;
      Reorderable : Boolean)
   is
      procedure Internal
        (Tree_Column : System.Address;
         Reorderable : Gint);
      pragma Import (C, Internal, "gtk_tree_view_column_set_reorderable");
   begin
      Internal (Get_Object (Tree_Column),
                Boolean'Pos (Reorderable));
   end Set_Reorderable;

   ---------------------
   -- Get_Reorderable --
   ---------------------

   function Get_Reorderable (Tree_Column : access Gtk_Tree_View_Column_Record)
                            return Boolean
   is
      function Internal (Tree_Column : System.Address)
                        return Gint;
      pragma Import (C, Internal, "gtk_tree_view_column_get_reorderable");
   begin
      return Boolean'Val (Internal (Get_Object (Tree_Column)));
   end Get_Reorderable;

   ------------------------
   -- Set_Sort_Column_Id --
   ------------------------

   procedure Set_Sort_Column_Id
     (Tree_Column    : access Gtk_Tree_View_Column_Record;
      Sort_Column_Id : Gint)
   is
      procedure Internal
        (Tree_Column    : System.Address;
         Sort_Column_Id : Gint);
      pragma Import (C, Internal, "gtk_tree_view_column_set_sort_column_id");
   begin
      Internal (Get_Object (Tree_Column),
                Sort_Column_Id);
   end Set_Sort_Column_Id;

   ------------------------
   -- Get_Sort_Column_Id --
   ------------------------

   function Get_Sort_Column_Id
     (Tree_Column : access Gtk_Tree_View_Column_Record)
     return Gint
   is
      function Internal (Tree_Column : System.Address)
                        return Gint;
      pragma Import (C, Internal, "gtk_tree_view_column_get_sort_column_id");
   begin
      return Internal (Get_Object (Tree_Column));
   end Get_Sort_Column_Id;

   ------------------------
   -- Set_Sort_Indicator --
   ------------------------

   procedure Set_Sort_Indicator
     (Tree_Column : access Gtk_Tree_View_Column_Record;
      Setting     : Boolean)
   is
      procedure Internal
        (Tree_Column : System.Address;
         Setting     : Gint);
      pragma Import (C, Internal, "gtk_tree_view_column_set_sort_indicator");
   begin
      Internal (Get_Object (Tree_Column),
                Boolean'Pos (Setting));
   end Set_Sort_Indicator;

   ------------------------
   -- Get_Sort_Indicator --
   ------------------------

   function Get_Sort_Indicator
     (Tree_Column : access Gtk_Tree_View_Column_Record)
     return Boolean
   is
      function Internal (Tree_Column : System.Address)
                        return Gint;
      pragma Import (C, Internal, "gtk_tree_view_column_get_sort_indicator");
   begin
      return Boolean'Val (Internal (Get_Object (Tree_Column)));
   end Get_Sort_Indicator;

   --------------------
   -- Set_Sort_Order --
   --------------------

   procedure Set_Sort_Order
     (Tree_Column : access Gtk_Tree_View_Column_Record;
      Order       : Gtk_Sort_Type)
   is
      procedure Internal
        (Tree_Column : System.Address;
         Order       : Gint);
      pragma Import (C, Internal, "gtk_tree_view_column_set_sort_order");
   begin
      Internal (Get_Object (Tree_Column),
                Gtk_Sort_Type'Pos (Order));
   end Set_Sort_Order;

   --------------------
   -- Get_Sort_Order --
   --------------------

   function Get_Sort_Order (Tree_Column : access Gtk_Tree_View_Column_Record)
                           return Gtk_Sort_Type
   is
      function Internal (Tree_Column : System.Address)
                        return Gint;
      pragma Import (C, Internal, "gtk_tree_view_column_get_sort_order");
   begin
      return Gtk_Sort_Type'Val (Internal (Get_Object (Tree_Column)));
   end Get_Sort_Order;

   ------------------------
   -- Cell_Set_Cell_Data --
   ------------------------

   procedure Cell_Set_Cell_Data
     (Tree_Column : access Gtk_Tree_View_Column_Record;
      Tree_Model  : access Gtk.Tree_Model.Gtk_Tree_Model_Record'Class;
      Iter        : Gtk.Tree_Model.Gtk_Tree_Iter;
      Is_Expander : Boolean;
      Is_Expanded : Boolean)
   is
      procedure Internal
        (Tree_Column : System.Address;
         Tree_Model  : System.Address;
         Iter        : System.Address;
         Is_Expander : Gint;
         Is_Expanded : Gint);
      pragma Import (C, Internal, "gtk_tree_view_column_cell_set_cell_data");
   begin
      Internal (Get_Object (Tree_Column),
                Get_Object (Tree_Model),
                Iter'Address,
                Boolean'Pos (Is_Expander),
                Boolean'Pos (Is_Expanded));
   end Cell_Set_Cell_Data;

   -------------------
   -- Cell_Get_Size --
   -------------------

   procedure Cell_Get_Size
     (Tree_Column : access Gtk_Tree_View_Column_Record;
      Cell_Area   : Gdk.Rectangle.Gdk_Rectangle;
      X_Offset    : out Gint;
      Y_Offset    : out Gint;
      Width       : out Gint;
      Height      : out Gint)
   is
      procedure Internal
        (Tree_Column : System.Address;
         Cell_Area   : Gdk.Rectangle.Gdk_Rectangle;
         X_Offset    : out Gint;
         Y_Offset    : out Gint;
         Width       : out Gint;
         Height      : out Gint);
      pragma Import (C, Internal, "gtk_tree_view_column_cell_get_size");
   begin
      Internal (Get_Object (Tree_Column),
                Cell_Area,
                X_Offset,
                Y_Offset,
                Width,
                Height);
   end Cell_Get_Size;

   -----------------
   -- Cell_Render --
   -----------------

   procedure Cell_Render
     (Tree_Column     : access Gtk_Tree_View_Column_Record;
      Window          : Gdk.Window.Gdk_Window;
      Background_Area : Gdk.Rectangle.Gdk_Rectangle;
      Cell_Area       : Gdk.Rectangle.Gdk_Rectangle;
      Expose_Area     : Gdk.Rectangle.Gdk_Rectangle;
      Flags           : Guint)
   is
      procedure Internal
        (Tree_Column     : System.Address;
         Window          : Gdk.Window.Gdk_Window;
         Background_Area : Gdk.Rectangle.Gdk_Rectangle;
         Cell_Area       : Gdk.Rectangle.Gdk_Rectangle;
         Expose_Area     : Gdk.Rectangle.Gdk_Rectangle;
         Flags           : Guint);
      pragma Import (C, Internal, "gtk_tree_view_column_cell_render");
   begin
      Internal (Get_Object (Tree_Column),
                Window,
                Background_Area,
                Cell_Area,
                Expose_Area,
                Flags);
   end Cell_Render;

--    ----------------
--    -- Cell_Event --
--    ----------------

--    function Cell_Event
--      (Tree_Column     : access Gtk_Tree_View_Column_Record;
--       Event           : Gdk.Event.Gdk_Event;
--       Path_String     : String;
--       Background_Area : Gdk.Rectangle.Gdk_Rectangle;
--       Cell_Area       : Gdk.Rectangle.Gdk_Rectangle;
--       Flags           : Guint)
--       return Boolean
--    is
--       function Internal
--         (Tree_Column     : System.Address;
--          Event           : Gdk.Event.Gdk_Event;
--          Path_String     : String;
--          Background_Area : Gdk.Rectangle.Gdk_Rectangle;
--          Cell_Area       : Gdk.Rectangle.Gdk_Rectangle;
--          Flags           : Guint)
--          return Gint;
--       pragma Import (C, Internal, "gtk_tree_view_column_cell_event");
--    begin
--       return Boolean'Val (Internal (Get_Object (Tree_Column),
--                                     Event,
--                                     Path_String & ASCII.NUL,
--                                     Background_Area,
--                                     Cell_Area,
--                                     Flags));
--    end Cell_Event;

   ----------------
   -- Cell_Focus --
   ----------------

   function Cell_Focus
     (Tree_Column : access Gtk_Tree_View_Column_Record;
      Direction   : Gint)
      return Boolean
   is
      function Internal
        (Tree_Column : System.Address;
         Direction   : Gint)
         return Gint;
      pragma Import (C, Internal, "gtk_tree_view_column_cell_focus");
   begin
      return Boolean'Val (Internal (Get_Object (Tree_Column),
                                    Direction));
   end Cell_Focus;

   ---------------------
   -- Cell_Draw_Focus --
   ---------------------

   procedure Cell_Draw_Focus
     (Tree_Column     : access Gtk_Tree_View_Column_Record;
      Window          : Gdk.Window.Gdk_Window;
      Background_Area : Gdk.Rectangle.Gdk_Rectangle;
      Cell_Area       : Gdk.Rectangle.Gdk_Rectangle;
      Expose_Area     : Gdk.Rectangle.Gdk_Rectangle;
      Flags           : Guint)
   is
      procedure Internal
        (Tree_Column     : System.Address;
         Window          : Gdk.Window.Gdk_Window;
         Background_Area : Gdk.Rectangle.Gdk_Rectangle;
         Cell_Area       : Gdk.Rectangle.Gdk_Rectangle;
         Expose_Area     : Gdk.Rectangle.Gdk_Rectangle;
         Flags           : Guint);
      pragma Import (C, Internal, "gtk_tree_view_column_cell_draw_focus");
   begin
      Internal (Get_Object (Tree_Column),
                Window,
                Background_Area,
                Cell_Area,
                Expose_Area,
                Flags);
   end Cell_Draw_Focus;

   ---------------------
   -- Cell_Is_Visible --
   ---------------------

   function Cell_Is_Visible (Tree_Column : access Gtk_Tree_View_Column_Record)
                             return Boolean
   is
      function Internal (Tree_Column : System.Address)
                         return Gint;
      pragma Import (C, Internal, "gtk_tree_view_column_cell_is_visible");
   begin
      return Boolean'Val (Internal (Get_Object (Tree_Column)));
   end Cell_Is_Visible;

   --------------------
   -- Cell_Set_Dirty --
   --------------------

   procedure Cell_Set_Dirty (Tree_Column : access Gtk_Tree_View_Column_Record)
   is
      procedure Internal (Tree_Column : System.Address);
      pragma Import (C, Internal, "gtk_tree_view_column_cell_set_dirty");
   begin
      Internal (Get_Object (Tree_Column));
   end Cell_Set_Dirty;

end Gtk.Tree_View_Column;
