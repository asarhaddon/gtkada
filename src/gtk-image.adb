
with Gdk; use Gdk;

package body Gtk.Image is

   ---------
   -- Get --
   ---------

   procedure Get
      (Image : in Gtk_Image'Class;
       Val   : in Gdk.Image.Gdk_Image'Class;
       Mask  : in Gdk.Bitmap.Gdk_Bitmap'Class)
   is
      procedure Internal
         (Image : in System.Address;
          Val   : in System.Address;
          Mask  : in System.Address);
      pragma Import (C, Internal, "gtk_image_get");
   begin
      Internal (Gtk.Get_Object (Image),
                Gdk.Get_Object (Val),
                Gdk.Get_Object (Mask));
   end Get;

   -------------
   -- Gtk_New --
   -------------

   procedure Gtk_New
      (Widget : out Gtk_Image;
       Val    : in Gdk.Image.Gdk_Image'Class;
       Mask   : in Gdk.Bitmap.Gdk_Bitmap'Class)
   is
      function Internal
         (Val    : in System.Address;
          Mask   : in System.Address)
          return      System.Address;
      pragma Import (C, Internal, "gtk_image_new");
   begin
      Gtk.Set_Object (Widget, Internal (Gdk.Get_Object (Val),
                                        Gdk.Get_Object (Mask)));
   end Gtk_New;

   ---------
   -- Set --
   ---------

   procedure Set
      (Image : in Gtk_Image'Class;
       Val   : in Gdk.Image.Gdk_Image'Class;
       Mask  : in Gdk.Bitmap.Gdk_Bitmap'Class)
   is
      procedure Internal
         (Image : in System.Address;
          Val   : in System.Address;
          Mask  : in System.Address);
      pragma Import (C, Internal, "gtk_image_set");
   begin
      Internal (Gtk.Get_Object (Image),
                Gdk.Get_Object (Val),
                Gdk.Get_Object (Mask));
   end Set;

end Gtk.Image;
