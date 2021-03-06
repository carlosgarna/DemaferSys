USE [master]
GO
CREATE DATABASE [Demafer]
GO
USE [Demafer]
GO
Create Proc [dbo].[ActualizarCargo]
@IdCargo Int,
@Descripcion Varchar(30),
@Mensaje Varchar(100) Out
As Begin
	If(Exists(Select * From Cargo Where Descripcion=@Descripcion))
		Set @Mensaje='No se ha Podido Actualizar los Datos porque ya Existe el cargo. '+@Descripcion
	Else Begin
		If(Not Exists(Select * From Cargo Where IdCargo=@IdCargo))
			Set @Mensaje='El Cargo no se Encuentra Registrado.'
		Else Begin
		Update Cargo Set Descripcion=@Descripcion Where IdCargo=@IdCargo
			Set @Mensaje='Los datos se han Actualizado Correctamente.'
			End
		End
	End




GO
/****** Object:  StoredProcedure [dbo].[ActualizarCategoria]    Script Date: 27/06/2018 10:15:00 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create proc [dbo].[ActualizarCategoria]
@IdC Int,
@Descripcion Varchar(50),
@Mensaje Varchar(50)  Out
As Begin
	If(Not Exists(Select * From Categoria Where IdCategoria=@IdC))
		Set @Mensaje='Categoria no se encuentra Registrada.'
	Else Begin
		Update Categoria Set Descripcion=@Descripcion Where IdCategoria=@IdC
		Set @Mensaje='Se ha Actualizado los Datos Correctamente.'
	End
End




GO
/****** Object:  StoredProcedure [dbo].[ActualizarCliente]    Script Date: 27/06/2018 10:15:00 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Proc [dbo].[ActualizarCliente]
(@DNI Char(8),
@RUC Char(11),
@Empresa varchar(200),
@Apellidos Varchar(50),
@Nombres Varchar(50),
@Direccion Varchar(100),
@Telefono Varchar(12),
@Mensaje Varchar(50) Output
)
As Begin
	If(Not Exists(Select * From Cliente Where Dni=@DNI and Dni is not null or Ruc=@RUC and Ruc is not null))
		Set @Mensaje='Los Datos del Cliente no Existen.'
	Else Begin
		Update Cliente Set Empresa=@Empresa,Apellidos=@Apellidos,Nombres=@Nombres,Direccion=@Direccion,Telefono=@Telefono 
		Where (DNI=@DNI and DNI <> '') or (Ruc=@RUC and Ruc <> '')
		Set @Mensaje='Registro Actualizado Correctamente.'
		End
	End


GO
/****** Object:  StoredProcedure [dbo].[ActualizarProducto]    Script Date: 27/06/2018 10:15:00 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Proc [dbo].[ActualizarProducto]
@IdProducto Int,
@IdCategoria Int,
@Nombre Varchar(50),
@Marca Varchar(80),
@Stock Int,
@PrecioCompra Decimal(6,2),
@PrecioVenta Decimal(6,2),
@Mensaje varchar(50) Out
As Begin
	If(Not Exists(Select * From Producto Where IdProducto=@IdProducto))
		Set @Mensaje='Producto no se encuentra Registrado.'
	Else Begin
		Update Producto Set IdCategoria=@IdCategoria,Nombre=@Nombre,Marca=@Marca,Stock=@Stock,
		PrecioCompra=@PrecioCompra,PrecioVenta=@PrecioVenta 
		Where IdProducto=@IdProducto
	Set @Mensaje='Registro Actualizado Correctamente.'
	End
End




GO
/****** Object:  StoredProcedure [dbo].[Buscar_Empleado]    Script Date: 27/06/2018 10:15:00 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create proc [dbo].[Buscar_Empleado](
@Datos Varchar(50)
)
As Begin
		Select E.*,C.Descripcion From Cargo C Inner Join Empleado E On C.IdCargo=E.IdCargo
		where E.Nombres like @Datos +'%' or E.Apellidos like @Datos +'%'
End




GO
/****** Object:  StoredProcedure [dbo].[BuscarCargo]    Script Date: 27/06/2018 10:15:00 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


Create Proc [dbo].[BuscarCargo]
@Descripcion varchar(30)
as begin
	Select * From Cargo Where Descripcion=@Descripcion
End




GO
/****** Object:  StoredProcedure [dbo].[BuscarCategoria]    Script Date: 27/06/2018 10:15:00 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create Proc [dbo].[BuscarCategoria]
@Datos Varchar(50)
As Begin
	Select * From Categoria Where Descripcion=@Datos
End




GO
/****** Object:  StoredProcedure [dbo].[DevolverDatosSesion]    Script Date: 27/06/2018 10:15:00 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create Proc [dbo].[DevolverDatosSesion]
@Usuario Varchar(20),
@Contraseña Varchar(12)
As Begin
	Select E.IdEmpleado,E.Apellidos+', '+E.Nombres 
	From Empleado E Inner Join Usuario U On E.IdEmpleado=U.IdEmpleado 
	Where U.Usuario=@Usuario And U.Contraseña=@Contraseña
	End




GO
/****** Object:  StoredProcedure [dbo].[FiltrarDatosCliente]    Script Date: 27/06/2018 10:15:00 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Proc [dbo].[FiltrarDatosCliente]
@Datos Varchar(80)
As Begin
	Select IdCliente,DNI,RUC,Empresa,Apellidos,Nombres,Direccion,Telefono 
	From Cliente Where DNI=@Datos or RUC=@Datos
End




GO
/****** Object:  StoredProcedure [dbo].[FiltrarDatosProducto]    Script Date: 27/06/2018 10:15:00 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create Proc [dbo].[FiltrarDatosProducto]
@Datos Varchar(50)
As Begin
	Select IdProducto,IdCategoria,Nombre,Marca,PrecioCompra,PrecioVenta,Stock,FechaVencimiento 
	From Producto where Nombre=@Datos or Marca=@Datos or Nombre+' '+Marca=@Datos
End




GO
/****** Object:  StoredProcedure [dbo].[GenerarIdEmpleado]    Script Date: 27/06/2018 10:15:00 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create Proc [dbo].[GenerarIdEmpleado]
@IdEmpleado Int Out
As Begin
	Declare @Cant As Int
	If(Not Exists(Select IdEmpleado From Empleado))
		Set @IdEmpleado=1
	Else Begin
		Set @IdEmpleado=(Select Max(IdEmpleado)+1 FROM Empleado)
		End
	End




GO
/****** Object:  StoredProcedure [dbo].[GenerarIdVenta]    Script Date: 27/06/2018 10:15:00 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create Proc [dbo].[GenerarIdVenta]
@IdVenta Int Out
As Begin
	If(Not Exists(Select IdVenta From Venta))
		Set @IdVenta=1
	Else Begin
		Set @IdVenta=(Select Max(IdVenta)+1 FROM Venta)
		End
	End




GO
/****** Object:  StoredProcedure [dbo].[IniciarSesion]    Script Date: 27/06/2018 10:15:00 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create Proc [dbo].[IniciarSesion]
@Usuario Varchar(20),
@Contraseña Varchar(12),
@Mensaje Varchar(50) Out
As Begin
	Declare @Empleado Varchar(50)
	If(Not Exists(Select Usuario From Usuario Where Usuario=@Usuario))
		Set @Mensaje='El Nombre de Usuario no Existe.'
		Else Begin
			If(Not Exists(Select Contraseña From Usuario Where Contraseña=@Contraseña))
				Set @Mensaje='Su Contraseña es Incorrecta.'
				Else Begin
					Set @Empleado=(Select E.Nombres+', '+E.Apellidos From Empleado E Inner Join Usuario U 
								   On E.IdEmpleado=U.IdEmpleado Where U.Usuario=@Usuario)
					    Begin
					Select Usuario,Contraseña From Usuario Where Usuario=@Usuario And Contraseña=@Contraseña
							Set @Mensaje='Bienvenido Sr(a): '+@Empleado+'.'
						End
				  End
		   End
   End




GO
/****** Object:  StoredProcedure [dbo].[ListadoEmpleados]    Script Date: 27/06/2018 10:15:00 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create Proc [dbo].[ListadoEmpleados]
As Begin
	Select E.*,C.Descripcion From Cargo C Inner Join Empleado E On C.IdCargo=E.IdCargo
End




GO
/****** Object:  StoredProcedure [dbo].[ListadoProductos]    Script Date: 27/06/2018 10:15:00 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Proc [dbo].[ListadoProductos]
As Begin
	Select IdProducto,IdCategoria,Nombre,Marca,PrecioCompra,PrecioVenta,Stock
	From Producto
End



GO
/****** Object:  StoredProcedure [dbo].[ListarCargo]    Script Date: 27/06/2018 10:15:00 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


Create Proc [dbo].[ListarCargo]
As Begin
	Select * From Cargo
	End




GO
/****** Object:  StoredProcedure [dbo].[ListarCategoria]    Script Date: 27/06/2018 10:15:00 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create Proc [dbo].[ListarCategoria]
As Begin
	Select * From Categoria
End




GO
/****** Object:  StoredProcedure [dbo].[ListarClientes]    Script Date: 27/06/2018 10:15:00 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Proc [dbo].[ListarClientes]
As Begin
	Select IdCliente,DNI,RUC,Empresa,Apellidos,Nombres,Direccion,Telefono From Cliente 
   End



GO
/****** Object:  StoredProcedure [dbo].[MantenimientoEmpleados]    Script Date: 27/06/2018 10:15:00 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create Proc [dbo].[MantenimientoEmpleados]
@IdEmpleado Int,
@IdCargo Int,
@Dni Char(8),
@Apellidos Varchar(30),
@Nombres Varchar(30),
@Sexo Char(1),
@FechaNac Date,
@Direccion Varchar(80),
@EstadoCivil Char(1),
@Mensaje Varchar(100) Out
As Begin
	If(Not Exists(Select * From Empleado Where Dni=@Dni))
		Begin
		Insert Empleado Values(@IdCargo,@Dni,@Apellidos,@Nombres,@Sexo,@FechaNac,@Direccion,@EstadoCivil)
			Set @Mensaje='Registrado Correctamente Ok.'
		End
	Else Begin
	If(Exists(Select * From Empleado Where Dni=@Dni))
		Begin
		Update Empleado Set IdCargo=@IdCargo,Dni=@Dni,Apellidos=@Apellidos,Nombres=@Nombres,Sexo=@Sexo,
		FechaNac=@FechaNac,Direccion=@Direccion,EstadoCivil=@EstadoCivil Where IdEmpleado=@IdEmpleado
			Set @Mensaje='Se Actualizaron los Datos Correctamente Ok.'
		End
	End
End




GO
/****** Object:  StoredProcedure [dbo].[Numero Correlativo]    Script Date: 27/06/2018 10:15:00 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create Procedure [dbo].[Numero Correlativo]
@TipoDocumento Varchar(7),
@NroCorrelativo Char(7)Out
As Begin
	Declare @Cant Int
	If(@TipoDocumento='Factura')
	Begin
	Select @Cant=Count(*)+1 From Venta where TipoDocumento='Factura'
		If @Cant<10
			Set @NroCorrelativo='000000'+Ltrim(Str(@Cant))
		Else
			If @Cant<100
				Set @NroCorrelativo='00000'+Ltrim(Str(@Cant))
			Else
				If @Cant<1000
					Set @NroCorrelativo='0000'+Ltrim(Str(@Cant))
				Else
					If(@Cant<10000)
						Set @NroCorrelativo='000'+LTRIM(STR(@Cant))
					Else
						If(@Cant<100000)
							Set @NroCorrelativo='00'+LTRIM(STR(@Cant))
						Else
							If(@Cant<1000000)
								Set @NroCorrelativo='0'+LTRIM(str(@Cant))
							Else
								If(@Cant<10000000)
									Set @NroCorrelativo=LTRIM(str(@Cant))
	End
	if(@TipoDocumento='Boleta')
	begin
		Select @Cant=Count(*)+1 From Venta where TipoDocumento='Boleta'
		If @Cant<10
			Set @NroCorrelativo='000000'+Ltrim(Str(@Cant))
		Else
			If @Cant<100
				Set @NroCorrelativo='00000'+Ltrim(Str(@Cant))
			Else
				If @Cant<1000
					Set @NroCorrelativo='0000'+Ltrim(Str(@Cant))
				Else
					If(@Cant<10000)
						Set @NroCorrelativo='000'+LTRIM(STR(@Cant))
					Else
						If(@Cant<100000)
							Set @NroCorrelativo='00'+LTRIM(STR(@Cant))
						Else
							If(@Cant<1000000)
								Set @NroCorrelativo='0'+LTRIM(str(@Cant))
							Else
								If(@Cant<10000000)
									Set @NroCorrelativo=LTRIM(STR(@Cant))
			End
	End




GO
/****** Object:  StoredProcedure [dbo].[RegistrarCargo]    Script Date: 27/06/2018 10:15:00 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create Proc [dbo].[RegistrarCargo]
@Descripcion Varchar(30),
@Mensaje Varchar(50) Out
As Begin
	If(Exists(Select * From Cargo Where Descripcion=@Descripcion))
		Set @Mensaje='El Cargo ya se Encuentra Registrado.'
	Else Begin
		Insert Cargo values(@Descripcion)
		Set @Mensaje='Registrado Correctamente.'
	End
End




GO
/****** Object:  StoredProcedure [dbo].[RegistrarCategoria]    Script Date: 27/06/2018 10:15:00 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create proc [dbo].[RegistrarCategoria]
@Descripcion Varchar(50),
@Mensaje Varchar(50)  Out
As Begin
	If(Exists(Select * From Categoria Where Descripcion=@Descripcion))
		Set @Mensaje='Categoria ya se encuentra Registrada.'
	Else Begin
		Insert Categoria Values(@Descripcion)
		Set @Mensaje='Registrado Correctamente.'
	End
End




GO
/****** Object:  StoredProcedure [dbo].[RegistrarCliente]    Script Date: 27/06/2018 10:15:00 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Proc [dbo].[RegistrarCliente]
(@DNI char(8),
@RUC char(11),
@Empresa varchar(200),
@Apellidos Varchar(50),
@Nombres Varchar(50),
@Direccion Varchar(100),
@Telefono Varchar(12),
@Mensaje Varchar(50) Output
)
As Begin
	If(Exists(Select * From Cliente Where Dni='47109408' and Dni <> '' or Ruc='' and Ruc <> ''))
		Set @Mensaje='Los Datos del Cliente ya Existen.'
	Else Begin
		Insert Cliente Values(@DNI,@RUC,@Empresa,@Apellidos,@Nombres,@Direccion,@Telefono)
		Set @Mensaje='Registrado Correctamente.'
		End
	End

GO
/****** Object:  StoredProcedure [dbo].[RegistrarDetalleVenta]    Script Date: 27/06/2018 10:15:00 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create Proc [dbo].[RegistrarDetalleVenta]
@IdProducto Int,
@IdVenta Int,
@Cantidad Int,
@PrecioUnitario Decimal(6,2),
@SubTotal Money,
@Mensaje Varchar(100) Out
As Begin
	Declare @Stock As Int
	Set @Stock=(Select Stock From Producto Where IdProducto=@IdProducto)
	Begin
		Insert DetalleVenta Values(@IdProducto,@IdVenta,@Cantidad,@PrecioUnitario,@SubTotal)
			Set @Mensaje='Registrado Correctamente.'
	End
		Update Producto Set Stock=@Stock-@Cantidad Where IdProducto=@IdProducto
End




GO
/****** Object:  StoredProcedure [dbo].[RegistrarProducto]    Script Date: 27/06/2018 10:15:00 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Proc [dbo].[RegistrarProducto]
@IdCategoria Int,
@Nombre Varchar(50),
@Marca Varchar(80),
@Stock Int,
@PrecioCompra Decimal(6,2),
@PrecioVenta Decimal(6,2),
@Mensaje varchar(50) Out
As Begin
	If(Exists(Select * From Producto Where Nombre=@Nombre And Marca=@Marca))
		Set @Mensaje='Este Producto ya ha sido Registrado.'
	Else Begin
		Insert Producto Values(@IdCategoria,@Nombre,@Marca,@Stock,@PrecioCompra,@PrecioVenta)
		Set @Mensaje='Registrado Correctamente.'
	End
End



GO
/****** Object:  StoredProcedure [dbo].[RegistrarUsuario]    Script Date: 27/06/2018 10:15:00 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create Proc [dbo].[RegistrarUsuario]
@IdEmpleado Int,
@Usuario Varchar(20),
@Contraseña Varchar(12),
@Mensaje Varchar(50) Out
As Begin
	If(Not Exists(Select * From Empleado Where IdEmpleado=@IdEmpleado))
		Set @Mensaje='Empleado no Registrado Ok.'
	Else Begin
		If(Exists(Select * From Usuario Where IdEmpleado=@IdEmpleado))
			Set @Mensaje='Este Empleado Ya Tiene una Cuenta de Usuario.'
		Else Begin
			If(Exists(Select * From Usuario Where Usuario=@Usuario))
				Set @Mensaje='El Usuario: '+@Usuario+' No está Disponible.'
			Else Begin
				Insert Usuario Values(@IdEmpleado,@Usuario,@Contraseña)
					Set @Mensaje='Usuario Registrado Correctamente.'
				 End
			 End
		 End
   End




GO
/****** Object:  StoredProcedure [dbo].[RegistrarVenta]    Script Date: 27/06/2018 10:15:00 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create Proc [dbo].[RegistrarVenta]
@IdEmpleado Int,
@IdCliente Int,
@Serie Char(5),
@NroDocumento Char(7),
@TipoDocumento Varchar(7),
@FechaVenta Date,
@Igv Money,
@Total Money,
@Mensaje Varchar(100) Out
As Begin
	Insert Venta Values(@IdEmpleado,@IdCliente,@Serie,@NroDocumento,@TipoDocumento,@FechaVenta,@Igv,@Total)
		Set @Mensaje='La Venta se ha Generado Correctamente.'
	End




GO
/****** Object:  StoredProcedure [dbo].[Serie Documento]    Script Date: 27/06/2018 10:15:00 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create Proc [dbo].[Serie Documento]
@Serie char(5) out
as begin
Set @Serie='00001'
end




GO
/****** Object:  Table [dbo].[Cargo]    Script Date: 27/06/2018 10:15:00 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Cargo](
	[IdCargo] [int] IDENTITY(1,1) NOT NULL,
	[Descripcion] [varchar](30) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IdCargo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Categoria]    Script Date: 27/06/2018 10:15:00 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Categoria](
	[IdCategoria] [int] IDENTITY(1,1) NOT NULL,
	[Descripcion] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IdCategoria] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Cliente]    Script Date: 27/06/2018 10:15:00 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Cliente](
	[IdCliente] [int] IDENTITY(1,1) NOT NULL,
	[DNI] [char](8) NULL,
	[RUC] [char](11) NULL,
	[Empresa] [varchar](200) NULL,
	[Apellidos] [varchar](50) NULL,
	[Nombres] [varchar](50) NULL,
	[Direccion] [varchar](100) NOT NULL,
	[Telefono] [varchar](12) NULL,
 CONSTRAINT [PK__Cliente__D5946642414EC519] PRIMARY KEY CLUSTERED 
(
	[IdCliente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[DetalleVenta]    Script Date: 27/06/2018 10:15:00 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DetalleVenta](
	[IdDetalleVenta] [int] IDENTITY(1,1) NOT NULL,
	[IdProducto] [int] NOT NULL,
	[IdVenta] [int] NOT NULL,
	[Cantidad] [int] NOT NULL,
	[PrecioUnitario] [decimal](6, 2) NOT NULL,
	[SubTotal] [money] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IdDetalleVenta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Empleado]    Script Date: 27/06/2018 10:15:00 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Empleado](
	[IdEmpleado] [int] IDENTITY(1,1) NOT NULL,
	[IdCargo] [int] NOT NULL,
	[Dni] [char](8) NOT NULL,
	[Apellidos] [varchar](30) NOT NULL,
	[Nombres] [varchar](30) NOT NULL,
	[Sexo] [char](1) NOT NULL,
	[FechaNac] [date] NOT NULL,
	[Direccion] [varchar](80) NOT NULL,
	[EstadoCivil] [char](1) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IdEmpleado] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Producto]    Script Date: 27/06/2018 10:15:00 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Producto](
	[IdProducto] [int] IDENTITY(1,1) NOT NULL,
	[IdCategoria] [int] NOT NULL,
	[Nombre] [varchar](50) NOT NULL,
	[Marca] [varchar](80) NULL,
	[Stock] [int] NOT NULL,
	[PrecioCompra] [decimal](6, 2) NOT NULL,
	[PrecioVenta] [decimal](6, 2) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IdProducto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Usuario]    Script Date: 27/06/2018 10:15:00 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Usuario](
	[IdUsuario] [int] IDENTITY(1,1) NOT NULL,
	[IdEmpleado] [int] NOT NULL,
	[Usuario] [varchar](20) NOT NULL,
	[Contraseña] [varchar](12) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IdUsuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Venta]    Script Date: 27/06/2018 10:15:00 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Venta](
	[IdVenta] [int] IDENTITY(1,1) NOT NULL,
	[IdEmpleado] [int] NOT NULL,
	[IdCliente] [int] NOT NULL,
	[Serie] [char](5) NOT NULL,
	[NroDocumento] [char](7) NOT NULL,
	[TipoDocumento] [varchar](7) NULL,
	[FechaVenta] [date] NOT NULL,
	[Igv] [money] NOT NULL,
	[Total] [money] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IdVenta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[Cargo] ON 

INSERT [dbo].[Cargo] ([IdCargo], [Descripcion]) VALUES (1, N'Administrador')
SET IDENTITY_INSERT [dbo].[Cargo] OFF
SET IDENTITY_INSERT [dbo].[Categoria] ON 

INSERT [dbo].[Categoria] ([IdCategoria], [Descripcion]) VALUES (1, N'Ferretería')
INSERT [dbo].[Categoria] ([IdCategoria], [Descripcion]) VALUES (2, N'Gasfitería')
INSERT [dbo].[Categoria] ([IdCategoria], [Descripcion]) VALUES (3, N'Griferías')
INSERT [dbo].[Categoria] ([IdCategoria], [Descripcion]) VALUES (4, N'Pintura')
INSERT [dbo].[Categoria] ([IdCategoria], [Descripcion]) VALUES (5, N'Electricidad')
INSERT [dbo].[Categoria] ([IdCategoria], [Descripcion]) VALUES (6, N'Cerrajería')
INSERT [dbo].[Categoria] ([IdCategoria], [Descripcion]) VALUES (7, N'Químicos')
INSERT [dbo].[Categoria] ([IdCategoria], [Descripcion]) VALUES (8, N'Acabados')
SET IDENTITY_INSERT [dbo].[Categoria] OFF
SET IDENTITY_INSERT [dbo].[Cliente] ON 

INSERT [dbo].[Cliente] ([IdCliente], [DNI], [RUC], [Empresa], [Apellidos], [Nombres], [Direccion], [Telefono]) VALUES (1, N'47660746', N'           ', N'', N'Vásquez Ventura', N'Juan', N'Urb. Santa Rosa', N'996687349')
INSERT [dbo].[Cliente] ([IdCliente], [DNI], [RUC], [Empresa], [Apellidos], [Nombres], [Direccion], [Telefono]) VALUES (2, N'12345678', N'           ', N'', N'Chiroque León', N'Antonio', N'Esperanza', N'995238917')
SET IDENTITY_INSERT [dbo].[Cliente] OFF
SET IDENTITY_INSERT [dbo].[Empleado] ON 

INSERT [dbo].[Empleado] ([IdEmpleado], [IdCargo], [Dni], [Apellidos], [Nombres], [Sexo], [FechaNac], [Direccion], [EstadoCivil]) VALUES (1, 1, N'34004387', N'Silva Terrones', N'Miguel', N'M', CAST(N'1990-11-01' AS Date), N'Urb. Santa Rosa', N'S')
SET IDENTITY_INSERT [dbo].[Empleado] OFF
SET IDENTITY_INSERT [dbo].[Producto] ON 

INSERT [dbo].[Producto] ([IdProducto], [IdCategoria], [Nombre], [Marca], [Stock], [PrecioCompra], [PrecioVenta]) VALUES (1, 4, N'Pintura color rojo', N'Anypsa', 11, CAST(35.00 AS Decimal(6, 2)), CAST(40.00 AS Decimal(6, 2)))
INSERT [dbo].[Producto] ([IdProducto], [IdCategoria], [Nombre], [Marca], [Stock], [PrecioCompra], [PrecioVenta]) VALUES (2, 1, N'Fierro 1 pulgada', N'Aceros Arequipa', 69, CAST(20.00 AS Decimal(6, 2)), CAST(23.00 AS Decimal(6, 2)))
INSERT [dbo].[Producto] ([IdProducto], [IdCategoria], [Nombre], [Marca], [Stock], [PrecioCompra], [PrecioVenta]) VALUES (3, 3, N'Tubos 2 pulgadas', N'PVC', 56, CAST(8.00 AS Decimal(6, 2)), CAST(10.00 AS Decimal(6, 2)))
INSERT [dbo].[Producto] ([IdProducto], [IdCategoria], [Nombre], [Marca], [Stock], [PrecioCompra], [PrecioVenta]) VALUES (4, 1, N'Cemento', N'Pacasmayo', 11, CAST(20.00 AS Decimal(6, 2)), CAST(25.00 AS Decimal(6, 2)))
SET IDENTITY_INSERT [dbo].[Producto] OFF
SET IDENTITY_INSERT [dbo].[Usuario] ON 

INSERT [dbo].[Usuario] ([IdUsuario], [IdEmpleado], [Usuario], [Contraseña]) VALUES (1, 1, N'Miguelito', N'123456')
SET IDENTITY_INSERT [dbo].[Usuario] OFF
ALTER TABLE [dbo].[DetalleVenta]  WITH CHECK ADD FOREIGN KEY([IdProducto])
REFERENCES [dbo].[Producto] ([IdProducto])
GO
ALTER TABLE [dbo].[DetalleVenta]  WITH CHECK ADD FOREIGN KEY([IdVenta])
REFERENCES [dbo].[Venta] ([IdVenta])
GO
ALTER TABLE [dbo].[Empleado]  WITH CHECK ADD FOREIGN KEY([IdCargo])
REFERENCES [dbo].[Cargo] ([IdCargo])
GO
ALTER TABLE [dbo].[Producto]  WITH CHECK ADD FOREIGN KEY([IdCategoria])
REFERENCES [dbo].[Categoria] ([IdCategoria])
GO
ALTER TABLE [dbo].[Usuario]  WITH CHECK ADD FOREIGN KEY([IdEmpleado])
REFERENCES [dbo].[Empleado] ([IdEmpleado])
GO
ALTER TABLE [dbo].[Venta]  WITH CHECK ADD  CONSTRAINT [FK__Venta__IdCliente__3D5E1FD2] FOREIGN KEY([IdCliente])
REFERENCES [dbo].[Cliente] ([IdCliente])
GO
ALTER TABLE [dbo].[Venta] CHECK CONSTRAINT [FK__Venta__IdCliente__3D5E1FD2]
GO
ALTER TABLE [dbo].[Venta]  WITH CHECK ADD FOREIGN KEY([IdEmpleado])
REFERENCES [dbo].[Empleado] ([IdEmpleado])
GO
ALTER TABLE [dbo].[Venta]  WITH CHECK ADD CHECK  (([TipoDocumento]='Factura' OR [TipoDocumento]='Boleta'))
GO
USE [master]
GO
ALTER DATABASE [Demafer] SET  READ_WRITE 
GO
