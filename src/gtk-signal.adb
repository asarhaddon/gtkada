with Ada.Exceptions;         use Ada.Exceptions;
with Unchecked_Conversion;
with Unchecked_Deallocation;

package body Gtk.Signal is

   Magic_Number : constant := 16#DEAD#;
   --  The magic number ensures that we get back a structure that we
   --  did build ourselves, and not a random memory zone. This can be
   --  removed in the production release but is useful when tracking
   --  bugs in the binding or in GTK itself.

   procedure Check_Magic_Number (Magic : in Integer);
   --  Check that the number Magic (that comes from the callback structure)
   --  is equal to Magic_Number (i.e. that it comes from a real callback
   --  structure built by a subprogram located in this package).

   function C_GTK_Signal_Connect (Obj       : System.Address;
                                  Name      : String;
                                  Func      : System.Address;
                                  Func_Data : System.Address;
                                  Destroy   : System.Address)
                      return Guint;
   pragma Import (C, C_GTK_Signal_Connect, "ada_gtk_signal_connect");

   function C_GTK_Signal_Connect_After (Obj       : System.Address;
                                        Name      : String;
                                        Func      : System.Address;
                                        Func_Data : System.Address;
                                        Destroy   : System.Address)
                      return Guint;
   pragma Import (C, C_GTK_Signal_Connect_After,
                  "ada_gtk_signal_connect_after");

   procedure C_GTK_Signal_Disconnect (Obj : System.Address;
                                      Id  : Guint);
   pragma Import (C, C_GTK_Signal_Disconnect, "gtk_signal_disconnect");

   procedure C_GTK_Signal_Handler_Block (Obj : in System.Address;
                                         Id  : in Guint);
   pragma Import (C, C_GTK_Signal_Handler_Block, "gtk_signal_handler_block");

   procedure C_GTK_Signal_Handler_Unblock (Obj : in System.Address;
                                           Id  : in Guint);
   pragma Import (C, C_GTK_Signal_Handler_Unblock,
                  "gtk_signal_handler_unblock");

   procedure C_GTK_Signal_Handler_Destroy (Obj : System.Address);
   pragma Import (C, C_GTK_Signal_Handler_Destroy,
                  "gtk_signal_handlers_destroy");

   ---------------
   --  Callback --
   ---------------

   package body Callback is

      type Data_Access is access Data_Type;

      type Data_Type_Record is
         record
            Magic : Integer;
            Data  : Data_Access;
            Func  : Callback;
         end record;

      type Data_Type_Access is access all Data_Type_Record;
      pragma Convention (C, Data_Type_Access);

      function Convert is new Unchecked_Conversion (Data_Type_Access,
                                                    System.Address);

      procedure Free (Data : in out Data_Type_Access);
      --  Free the memory associated with the callback's data

      procedure General_Cb (Widget : System.Address;
                            Data   : Data_Type_Access);
      pragma Convention (C, General_Cb);
      --  This is the only real callback function which is called from
      --  C. It dispatches the call to the real callback, after converting
      --  the widget from a C pointer to an Ada Widget type

      ----------------
      -- General_Cb --
      ----------------

      procedure General_Cb (Widget : System.Address;
                            Data   : Data_Type_Access)
      is
         AWidget : Widget_Type;
      begin
         Check_Magic_Number (Data.Magic);
         Set_Object (AWidget, Widget);
         Data.Func (AWidget, Data.Data.all);
      end General_Cb;

      ----------
      -- Free --
      ----------

      procedure Free (Data : in out Data_Type_Access) is
         procedure Internal is new Unchecked_Deallocation (Data_Type_Record,
                                                           Data_Type_Access);
         procedure Internal_2 is new Unchecked_Deallocation (Data_Type,
                                                             Data_Access);
      begin
         Internal_2 (Data.Data);
         Internal (Data);
      end Free;

      -------------
      -- Connect --
      -------------

      function Connect
        (Obj       : in Widget_Type'Class;
         Name      : in String;
         Func      : in Callback;
         Func_Data : in Data_Type)
         return Guint
      is
         D : Data_Type_Access :=
          new Data_Type_Record'(Magic => Magic_Number,
                                Data  => new Data_Type'(Func_Data),
                                Func  => Func);
      begin
         return C_GTK_Signal_Connect
           (Obj       => Get_Object (Obj),
            Name      => Name & Ascii.NUL,
            Func      => General_Cb'Address,
            Func_Data => Convert (D),
            Destroy   => Free'Address);
      end Connect;

      -------------------
      -- Connect_After --
      -------------------

      function Connect_After
        (Obj       : in Widget_Type'Class;
         Name      : in String;
         Func      : in Callback;
         Func_Data : in Data_Type)
         return Guint
      is
         D : Data_Type_Access :=
          new Data_Type_Record'(Magic => Magic_Number,
                                Data  => new Data_Type'(Func_Data),
                                Func  => Func);
      begin
         return C_GTK_Signal_Connect_After
           (Obj       => Get_Object (Obj),
            Name      => Name & Ascii.NUL,
            Func      => General_Cb'Address,
            Func_Data => Convert (D),
            Destroy   => Free'Address);
      end Connect_After;

      ----------------
      -- Disconnect --
      ----------------

      procedure Disconnect (Object     : in Widget_Type;
                            Handler_Id : in Guint) is
      begin
         C_GTK_Signal_Disconnect (Obj => Get_Object (Object),
                                  Id  => Handler_Id);
      end Disconnect;

      -------------------
      -- Handler_Block --
      -------------------

      procedure Handler_Block (Obj        : in Widget_Type'Class;
                               Handler_Id : in Guint)
      is
      begin
         C_GTK_Signal_Handler_Block (Obj => Get_Object (Obj),
                                     Id  => Handler_Id);
      end Handler_Block;

      ---------------------
      -- Handler_Unblock --
      ---------------------

      procedure Handler_Unblock (Obj        : in Widget_Type'Class;
                                 Handler_Id : in Guint)
      is
      begin
         C_GTK_Signal_Handler_Unblock (Obj => Get_Object (Obj),
                                       Id  => Handler_Id);
      end Handler_Unblock;


      -------------------------------
      --  Void_Callback_Procedure  --
      -------------------------------

      procedure Void_Callback_Procedure (Widget : in out Widget_Type'Class;
                                         Data   : in     Data_Type) is
      begin
         null;
      end Void_Callback_Procedure;

   end Callback;

   ------------------------
   -- Check_Magic_Number --
   ------------------------

   procedure Check_Magic_Number (Magic : in Integer) is
   begin
      if Magic /= Magic_Number then
         Raise_Exception (Program_Error'Identity,
                          "Bad magic number in callback");
      end if;
   end Check_Magic_Number;

   ------------------------------------------------------------
   -- Void_Callback                                          --
   ------------------------------------------------------------

   package body Void_Callback is

      type Data_Type_Record is
         record
            Magic : Integer;
            Func  : Callback;
         end record;

      type Data_Type_Access is access all Data_Type_Record;
      pragma Convention (C, Data_Type_Access);

      function Convert is new Unchecked_Conversion (Data_Type_Access,
                                                    System.Address);

      procedure Free (Data : in out Data_Type_Access);

      procedure General_Cb (Widget : System.Address;
                            Data   : Data_Type_Access);
      pragma Convention (C, General_Cb);

      ----------
      -- Free --
      ----------

      procedure Free (Data : in out Data_Type_Access) is
         procedure Internal is new Unchecked_Deallocation (Data_Type_Record,
                                                           Data_Type_Access);
      begin
         Internal (Data);
      end Free;

      ----------------
      -- General_Cb --
      ----------------

      procedure General_Cb (Widget : System.Address;
                            Data   : Data_Type_Access)
      is
         AWidget : Widget_Type;
      begin
         Check_Magic_Number (Data.Magic);
         Set_Object (AWidget, Widget);
         Data.Func (AWidget);
      end General_Cb;

      -------------
      -- Connect --
      -------------

      function Connect
        (Obj  : in Widget_Type'Cl   ass;
         Name : in String;
         Func : in Callback)
         return Guint
      is
         D : Data_Type_Access := new Data_Type_Record'(Magic => Magic_Number,
                                                       Func  => Func);
      begin
         return C_GTK_Signal_Connect
           (Obj       => Get_Object (Obj),
            Name      => Name & Ascii.NUL,
            Func      => General_Cb'Address,
            Func_Data => Convert (D),
            Destroy   => Free'Address);
      end Connect;

      -------------------
      -- Connect_After --
      -------------------

      function Connect_After
        (Obj  : in Widget_Type'Class;
         Name : in String;
         Func : in Callback)
         return Guint
      is
         D : Data_Type_Access := new Data_Type_Record'(Magic => Magic_Number,
                                                       Func  => Func);
      begin
         return C_GTK_Signal_Connect_After
           (Obj       => Get_Object (Obj),
            Name      => Name & Ascii.NUL,
            Func      => General_Cb'Address,
            Func_Data => Convert (D),
            Destroy   => Free'Address);
      end Connect_After;

      ----------------
      -- Disconnect --
      ----------------

      procedure Disconnect (Object     : in Widget_Type;
                            Handler_Id : in Guint) is
      begin
         C_GTK_Signal_Disconnect (Obj => Get_Object (Object),
                                  Id  => Handler_Id);
      end Disconnect;

      -------------------
      -- Handler_Block --
      -------------------

      procedure Handler_Block (Obj        : in Widget_Type'Class;
                               Handler_Id : in Guint)
      is
      begin
         C_GTK_Signal_Handler_Block (Obj => Get_Object (Obj),
                                     Id  => Handler_Id);
      end Handler_Block;

      ---------------------
      -- Handler_Unblock --
      ---------------------

      procedure Handler_Unblock (Obj        : in Widget_Type'Class;
                                 Handler_Id : in Guint)
      is
      begin
         C_GTK_Signal_Handler_Unblock (Obj => Get_Object (Obj),
                                       Id  => Handler_Id);
      end Handler_Unblock;

      -------------------------------
      --  Void_Callback_Procedure  --
      -------------------------------

      procedure Void_Callback_Procedure (Widget : in out Widget_Type'Class) is
      begin
         null;
      end Void_Callback_Procedure;

   end Void_Callback;


   ---------------------------------------------------------------
   -- Object_Callback                                           --
   ---------------------------------------------------------------

   package body Object_Callback is

      type Data_Type_Record is
         record
            Magic : Integer;
            Func  : Callback;
            Data  : Widget_Type;
         end record;

      type Data_Type_Access is access all Data_Type_Record;
      pragma Convention (C, Data_Type_Access);

      function Convert is new Unchecked_Conversion (Data_Type_Access,
                                                    System.Address);

      procedure Free (Data : in out Data_Type_Access);
      procedure General_Cb (Widget : System.Address;
                            Data   : Data_Type_Access);
      pragma Convention (C, General_Cb);

      ----------
      -- Free --
      ----------

      procedure Free (Data : in out Data_Type_Access) is
         procedure Internal is new Unchecked_Deallocation (Data_Type_Record,
                                                           Data_Type_Access);
      begin
         Internal (Data);
      end Free;

      ----------------
      -- General_Cb --
      ----------------

      procedure General_Cb (Widget : System.Address;
                            Data   : Data_Type_Access)
      is
      begin
         Check_Magic_Number (Data.Magic);
         Data.Func (Data.Data);
      end General_Cb;

      -------------
      -- Connect --
      -------------

      function Connect
        (Obj         : in Object.Gtk_Object'Class;
         Name        : in String;
         Func        : in Callback;
         Slot_Object : in Widget_Type'Class)
         return Guint
      is
         D : Data_Type_Access := new Data_Type_Record'(Magic => Magic_Number,
                                                       Data  => Slot_Object,
                                                       Func  => Func);
      begin
         return C_GTK_Signal_Connect
           (Obj       => Get_Object (Obj),
            Name      => Name & Ascii.NUL,
            Func      => General_Cb'Address,
            Func_Data => Convert (D),
            Destroy   => Free'Address);
      end Connect;

      -------------------
      -- Connect_After --
      -------------------

      function Connect_After
        (Obj         : in Object.Gtk_Object'Class;
         Name        : in String;
         Func        : in Callback;
         Slot_Object : in Widget_Type'Class)
         return Guint
      is
         D : Data_Type_Access := new Data_Type_Record'(Magic => Magic_Number,
                                                       Data  => Slot_Object,
                                                       Func  => Func);
      begin
         return C_GTK_Signal_Connect_After
           (Obj       => Get_Object (Obj),
            Name      => Name & Ascii.NUL,
            Func      => General_Cb'Address,
            Func_Data => Convert (D),
            Destroy   => Free'Address);
      end Connect_After;

      ----------------
      -- Disconnect --
      ----------------

      procedure Disconnect (Object     : in Widget_Type;
                            Handler_Id : in Guint) is
      begin
         C_GTK_Signal_Disconnect (Obj => Get_Object (Object),
                                  Id  => Handler_Id);
      end Disconnect;

      -------------------
      -- Handler_Block --
      -------------------

      procedure Handler_Block (Obj        : in Object.Gtk_Object'Class;
                               Handler_Id : in Guint)
      is
      begin
         C_GTK_Signal_Handler_Block (Obj => Get_Object (Obj),
                                     Id  => Handler_Id);
      end Handler_Block;

      ---------------------
      -- Handler_Unblock --
      ---------------------

      procedure Handler_Unblock (Obj        : in Object.Gtk_Object'Class;
                                 Handler_Id : in Guint)
      is
      begin
         C_GTK_Signal_Handler_Unblock (Obj => Get_Object (Obj),
                                       Id  => Handler_Id);
      end Handler_Unblock;

   end Object_Callback;

   ----------------------
   -- Handlers_Destroy --
   ----------------------

   procedure Handlers_Destroy (Obj : in Object.Gtk_Object'Class)
   is
   begin
      C_GTK_Signal_Handler_Destroy (Obj => Get_Object (Obj));
   end Handlers_Destroy;

end Gtk.Signal;
