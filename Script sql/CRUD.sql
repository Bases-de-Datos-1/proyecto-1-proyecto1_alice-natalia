-- Bases de datos I
-- Sistema de Gestion Hotelera

use SistemaGestionHotelera

--CRUD de la base de datos

--Tabla Hospedaje
--registrar hospedajes
create procedure RegistrarHospedaje
    @CedulaJuridica varchar(20),
    @NombreHospedaje varchar(50),
    @TipoHospedaje int,
    @UrlSitioWeb varchar(255) = null,
    @CorreoElectronico varchar(100),
    @ReferenciasGPS varchar(100)
as
begin
	begin try
		insert into Hospedaje (
            CedulaJuridica,
            NombreHospedaje,
            TipoHospedaje,
            UrlSitioWeb,
            CorreoElectronico,
            ReferenciasGPS
        )
        values (
            @CedulaJuridica,
            @NombreHospedaje,
            @TipoHospedaje,
            @UrlSitioWeb,
            @CorreoElectronico,
            @ReferenciasGPS
        )
        select scope_identity() as IdHospedaje
	end try 
	begin catch
		select
			error_number() as NumeroError,
			error_message() as MensajeError
		end catch
end

--consultar hospedajes
create procedure ConsultarHospedajes
as 
begin 
	select 
        IdHospedaje,
        CedulaJuridica,
        NombreHospedaje,
        TipoHospedaje,
        UrlSitioWeb,
        CorreoElectronico,
        ReferenciasGPS
    from Hospedaje
end

--consultar un hospedaje por Id
create procedure ConsultarHospedajePorId
	@IdHospedaje int 
as
begin 
	select 
        IdHospedaje,
        CedulaJuridica,
        NombreHospedaje,
        TipoHospedaje,
        UrlSitioWeb,
        CorreoElectronico,
        ReferenciasGPS
    from Hospedaje
    where IdHospedaje = @IdHospedaje
end

--consultar hospedajes por tipo
create procedure ConsultarHospedajePorTipo
    @TipoHospedaje int
as 
begin
	select
        IdHospedaje,
        CedulaJuridica,
        NombreHospedaje,
        TipoHospedaje,
        UrlSitioWeb,
        CorreoElectronico,
        ReferenciasGPS
    from Hospedaje
    where TipoHospedaje = @TipoHospedaje
end

--consultar hospedaje por nombre
create procedure ConsultarHospeajesPorNombre
	@NombreHospedaje varchar(50)
as
begin
	select
        IdHospedaje,
        CedulaJuridica,
        NombreHospedaje,
        TipoHospedaje,
        UrlSitioWeb,
        CorreoElectronico,
        ReferenciasGPS
    from Hospedaje
    where NombreHospedaje like '%' + @NombreHospedaje + '%'
end

--actualizar informacion Hospedaje
create procedure ActualizarInfoHospedaje
    @IdHospedaje int,
    @CedulaJuridica varchar(20),
    @NombreHospedaje varchar(50),
    @TipoHospedaje int,
    @UrlSitioWeb varchar(255) = null,
    @CorreoElectronico varchar(100),
    @ReferenciasGPS varchar(100)
as 
begin
	begin try 
		update Hospedaje set
            CedulaJuridica = @CedulaJuridica,
            NombreHospedaje = @NombreHospedaje,
            TipoHospedaje = @TipoHospedaje,
            UrlSitioWeb = @UrlSitioWeb,
            CorreoElectronico = @CorreoElectronico,
            ReferenciasGPS = @ReferenciasGPS
        where IdHospedaje = @IdHospedaje
        
		select 1 as resultado 
    end try
	begin catch
		select 
			error_number() as NumeroError,
			error_message() as MensajeError
    end catch
end
  
--Eliminar Hospedaje
create procedure EliminarHospedaje
	@IdHospedaje int
as 
begin
	begin try
		delete from Hospedaje
		where IdHospedaje = @IdHospedaje

		select 1 as resulta 
	end try
	begin catch
		select 
			error_number() as NumeroError,
			error_message() as MensajeErro
	end catch
end

--Tabla DireccionHospeadaje
--registrar la direcci�n Hospedajes
create procedure RegistrarDireccionHospedaje
    @IdHospedaje int,
    @SenasExactas varchar(255),
    @Barrio varchar(100),
    @Provincia int,
    @Canton varchar(50),
    @Distrito varchar(50)
as 
begin
	begin try
		insert into DireccionHospedaje (
            IdHospedaje,
            SenasExactas,
            Barrio,
            Provincia,
            Canton,
            Distrito
        )
        values (
            @IdHospedaje,
            @SenasExactas,
            @Barrio,
            @Provincia,
            @Canton,
            @Distrito
        )
        
		select scope_identity() as IdDireccion
	end try
	begin catch
		select
			error_number() as NumeroError,
			error_message() as MensajeErro
	end catch
end 
			
--consultar todas las direcciones
create procedure ConsultarDireccionesHospedaje
as
begin
	select
        d.IdDireccion,
        d.IdHospedaje,
        h.NombreHospedaje,
        d.SenasExactas,
        d.Barrio,
        d.Provincia,
        p.NombreProvincia,
        d.Canton,
        d.Distrito
    from DireccionHospedaje d
    inner join Hospedaje h on d.IdHospedaje = h.IdHospedaje
    inner join Provincia p on d.Provincia = p.IdProvincia
end

--consultar la direcci�n por IdDireccion
create procedure ConsultarDireccionHospedajePorId
    @IdDireccion int
as
begin
	select 
        d.IdDireccion,
        d.IdHospedaje,
        h.NombreHospedaje,
        d.SenasExactas,
        d.Barrio,
        d.Provincia,
        p.NombreProvincia,
        d.Canton,
        d.Distrito
    from DireccionHospedaje d
    inner join Hospedaje h on d.IdHospedaje = h.IdHospedaje
    inner join Provincia p on d.Provincia = p.IdProvincia
    where d.IdDireccion = @IdDireccion
end

--consultar la direcci�n por Hospedaje
create procedure ConsultarDireccionPorHospedaje
    @IdHospedaje int
as
begin
	select 
        d.IdDireccion,
        d.SenasExactas,
        d.Barrio,
        d.Provincia,
        p.NombreProvincia,
        d.Canton,
        d.Distrito
    from DireccionHospedaje d
    inner join Provincia p on d.Provincia = p.IdProvincia
    where d.IdHospedaje = @IdHospedaje
end

-- actualizar direcci�n de hospedaje
create procedure ActualizarDireccionHospedaje
    @IdDireccion int,
    @SenasExactas varchar(255),
    @Barrio varchar(100),
    @Provincia int,
    @Canton varchar(50),
    @Distrito varchar(50)
as 
begin
	begin try
		update DireccionHospedaje set
            SenasExactas = @SenasExactas,
            Barrio = @Barrio,
            Provincia = @Provincia,
            Canton = @Canton,
            Distrito = @Distrito
		where IdDireccion = @IdDireccion

		select 1 as resultado

    end try
    begin catch
		select
			error_number() as NumeroError,
			error_message() as MensajeErro
	end catch
end

--eliminar direccion de hospedaje
create procedure EliminarDireccionHospedaje
    @IdDireccion int
as
begin
    begin try
		
        delete from DireccionHospedaje
        where IdDireccion = @IdDireccion
        
        select 1 as resultado 
	end try
	begin catch
		select
            error_number() as NumeroError,
			error_message() as MensajeErro
	end catch
end

-- Tabla TelefonoHospedaje
-- registrar tel�fono de hospedaje
create procedure RegistarTelefonoHospedaje
    @NumeroTelefono varchar(20),
    @IdHospedaje int
as
begin
    begin try
		insert into TelefonoHospedaje (
            NumeroTelefono,
            IdHospedaje
        )
        values (
            @NumeroTelefono,
            @IdHospedaje
        )
        
		select scope_identity() as IdTelefonoHospedaje
    end try
	begin catch
		select
			error_number() as NumeroError,
			error_message() as MensajeErro
	end catch
end

--Consultar todos los tel�fonos
create procedure ConsultarTelefonosHospedaje
as
begin
    select 
        t.IdTelefonoHospedaje,
        t.NumeroTelefono,
        t.IdHospedaje,
        h.NombreHospedaje
    from TelefonoHospedaje t
	inner join Hospedaje h on t.IdHospedaje = h.IdHospedaje
end

--Consultar tel�fono por ID
create procedure ConsultarTelefonoHospedajePorId
    @IdTelefonoHospedaje int
as
begin
    select 
        t.IdTelefonoHospedaje,
        t.NumeroTelefono,
        t.IdHospedaje,
        h.NombreHospedaje
    from TelefonoHospedaje t
    inner join Hospedaje h on t.IdHospedaje = h.IdHospedaje
    where t.IdTelefonoHospedaje = @IdTelefonoHospedaje
end

--actualizar tel�fono de hospedaje
create procedure ActualizarTelefonoHospedaje
    @IdTelefonoHospedaje int,
    @NumeroTelefono varchar(20)
as
begin
    begin try
      update TelefonoHospedaje set
            NumeroTelefono = @NumeroTelefono
        where IdTelefonoHospedaje = @IdTelefonoHospedaje
        
        select 1 as resultado 
	end try
	begin catch
		select
			error_number() as NumeroError,
			error_message() as MensajeErro
	end catch
end

--eliminar tel�fono de hospedaje
create procedure EliminarTelefonoHospedaje
    @IdTelefonoHospedaje int
as
begin
    begin try
		delete from TelefonoHospedaje
        where IdTelefonoHospedaje = @IdTelefonoHospedaje
        
        select 1 as resultado 

    end try
    begin catch
		select 
            error_number() as NumeroError,
			error_message() as MensajeErro
    end catch
end


--Tabla ServicioHospedaje
--registrar servicio a hospedaje
create procedure RegistrarServicioHospedaje
    @IdHospedaje int,
    @IdServicio int
as
begin
    begin try
		if not exists (select 1 from ServicioHospedaje where IdHospedaje = @IdHospedaje and IdServicio = @IdServicio) 
        begin
			insert into ServicioHospedaje (
                IdHospedaje,
                IdServicio
            )
            values (
                @IdHospedaje,
                @IdServicio
            )
            
			select scope_identity() as IdServicioHospedaje
        end
        else
        begin
            select -1 as IdServicioHospedaje 
        end
	end try
	begin catch
		select 
            error_number() as NumeroError,
			error_message() as MensajeErro
    end catch
end

--consultar todos los servicios de hospedajes
create procedure ConsultarServiciosHospedajes
as 
begin
	select
        sh.IdServicioHospedaje,
        sh.IdHospedaje,
        h.NombreHospedaje,
        sh.IdServicio,
        s.NombreServicio,
        s.descripcion
    from ServicioHospedaje sh
	inner join Hospedaje h on sh.IdHospedaje = h.IdHospedaje
    inner joinServicio s on sh.IdServicio = s.IdServicio
end

--consultar servicios por hospedaje
create procedure ConsultarServiciosPorHospedaje
    @IdHospedaje int
as
begin
	select 
        sh.IdServicioHospedaje,
        sh.IdServicio,
        s.NombreServicio,
        s.descripcion
    from ServicioHospedaje sh
	inner join Servicio s on sh.IdServicio = s.IdServicio
    where sh.IdHospedaje = @IdHospedaje
end

--eliminar servicio de hospedaje por ID
create procedure EliminarServicioHospedajePorIds
    @IdHospedaje int,
    @IdServicio int
as 
begin
	begin try
		delete from ServicioHospedaje
        where IdHospedaje = @IdHospedaje and IdServicio = @IdServicio

		select 1 as resultado
	end try
	begin catch
		select 
            error_number() as NumeroError,
			error_message() as MensajeErro
    end catch
end

--registrar red social a hospedaje
create procedure RegistraarRedSocialHospedaje
    @IdHospedaje int,
    @IdRedSocial int,
    @NombreUsuario varchar(50),
    @UrlPerfil varchar(255)
as
begin 
    begin try
        if not exists (select 1 from RedSocialHospedaje 
                      where IdHospedaje = @IdHospedaje and IdRedSocial = @IdRedSocial)
        begin
            insert into RedSocialHospedaje (
                IdHospedaje,
                IdRedSocial,
                NombreUsuario,
                UrlPerfil
            )
            values (
                @IdHospedaje,
                @IdRedSocial,
                @NombreUsuario,
                @UrlPerfil
            )
            
			select scope_identity() as IdRedSocialHospedaje
		end 
		else
		begin 
            select -1 as IdRedSocialHospedaje -- Ya existe
        end
    end try
	begin catch
		select 
            error_number() as NumeroError,
			error_message() as MensajeErro
    end catch
end

--consultar todas las redes sociales de hospedajes
create procedure ConsultarRedesSocialesHospedajes
as 
begin
    select 
        rsh.IdRedSocialHospedaje,
        rsh.IdHospedaje,
        h.NombreHospedaje,
        rsh.IdRedSocial,
        rs.NombreRedSocial,
        rs.Icono,
        rsh.NombreUsuario,
        rsh.UrlPerfil
    from RedSocialHospedaje rsh
	inner join Hospedaje h on rsh.IdHospedaje = h.IdHospedaje
    inner join RedSocial rs on rsh.IdRedSocial = rs.IdRedSocial
end

--consultar hospedajes por red social
create procedure ConsultarHospedajesPorRedSocial
    @IdRedSocial int
as
begin 
    select  
        rsh.IdRedSocialHospedaje,
        rsh.IdHospedaje,
        h.NombreHospedaje,
        rsh.NombreUsuario,
        rsh.UrlPerfil
    from RedSocialHospedaje rsh
	inner join Hospedaje h on rsh.IdHospedaje = h.IdHospedaje
    where rsh.IdRedSocial = @IdRedSocial
end

--actualizar red social de hospedaje
create procedure ActualizarRedSocialHospedaje
    @IdRedSocialHospedaje int,
    @NombreUsuario varchar(50),
    @UrlPerfil varchar(255)
as
begin
    begin try
       update RedSocialHospedaje set
            NombreUsuario = @NombreUsuario,
            UrlPerfil = @UrlPerfil
        where IdRedSocialHospedaje = @IdRedSocialHospedaje
        
		select 1 as resultado
	end try
	begin catch
		select 
            error_number() as NumeroError,
			error_message() as MensajeErro
    end catch
end

--eliminar red social de hospedaje por IDs
create procedure EliminarRedSocialHospedajePorIds
    @IdHospedaje int,
    @IdRedSocial int
as
begin
	begin try
		delete from RedSocialHospedaje
		where  IdHospedaje = @IdHospedaje and IdRedSocial = @IdRedSocial 
   
        select 1 as resultado
	end try
	begin catch
		select 
            error_number() as NumeroError,
			error_message() as MensajeErro
    end catch
end

--Table TipoHabitacion
--registro de tipo de habitaci�n
create procedure RegistrarTipoHabitacion
    @NombreTipoHabitacion varchar(50),
    @IdTipoCama int,
    @IdHospedaje int,
    @Capacidad int,
    @descripcion text,
    @Precio decimal(10,2)
as 
begin 
	begin try
		insert into TipoHabitacion (
            NombreTipoHabitacion,
            IdTipoCama,
            IdHospedaje,
            Capacidad,
            descripcion,
            Precio
        )
        values (
            @NombreTipoHabitacion,
            @IdTipoCama,
            @IdHospedaje,
            @Capacidad,
            @descripcion,
            @Precio
        )
        
		select scope_identity() as IdTipoHabitacion
	end try
	begin catch
		select 
			error_number() as NumeroError,
			error_message() as MensajeError
	end catch
end

-- Consultar todos los tipos de habitaci�n
create procedure ConsultarTiposHabitacion
as
begin
	select 
        th.IdTipoHabitacion,
        th.NombreTipoHabitacion,
        th.IdTipoCama,
        tc.NombreTipoCama,
        th.IdHospedaje,
        h.NombreHospedaje,
        th.Capacidad,
        th.descripcion,
        th.Precio
    from TipoHabitacion th
	inner join TipoCama tc on th.IdTipoCama = tc.IdTipoCama
    inner join Hospedaje h on th.IdHospedaje = h.IdHospedaje
end 

-- Consultar tipo de habitaci�n por ID
create procedure ConsultarTipoHabitacionPorId
    @IdTipoHabitacion int
as
begin
	select 
        th.IdTipoHabitacion,
        th.NombreTipoHabitacion,
        th.IdTipoCama,
        tc.NombreTipoCama,
        th.IdHospedaje,
        h.NombreHospedaje,
        th.Capacidad,
        th.descripcion,
        th.Precio
    from TipoHabitacion th
    inner join TipoCama tc on th.IdTipoCama = tc.IdTipoCama
    inner join Hospedaje h on th.IdHospedaje = h.IdHospedaje
    where th.IdTipoHabitacion = @IdTipoHabitacion
end

--consultar tipos de habitaci�n por hospedaje
create procedure ConsutalarTiposHabitacionPorHospedaje
    @IdHospedaje int
as
begin
	select 
        th.IdTipoHabitacion,
        th.NombreTipoHabitacion,
        th.IdTipoCama,
        tc.NombreTipoCama,
        th.Capacidad,
        th.descripcion,
        th.Precio
    from TipoHabitacion th
	inner join TipoCama tc on th.IdTipoCama = tc.IdTipoCama
    where th.IdHospedaje = @IdHospedaje
end

--actualizar tipo de habitaci�n
create procedure ActualizarTipoHabitacion
    @IdTipoHabitacion int,
    @NombreTipoHabitacion varchar(50),
    @IdTipoCama int,
    @Capacidad int,
    @descripcion text,
    @Precio decimal(10,2)
as
begin
	begin try
       update TipoHabitacion set
            NombreTipoHabitacion = @NombreTipoHabitacion,
            IdTipoCama = @IdTipoCama,
            Capacidad = @Capacidad,
            descripcion = @descripcion,
            Precio = @Precio
        where IdTipoHabitacion = @IdTipoHabitacion
        
        select 1 as resultado 
    end try
	begin catch
		select 
			error_number() as NumeroError,
			error_message() as MensajeError
    end catch
end

--eliminar tipo de habitaci�n
create procedure EliminarTipoHabitacion
    @IdTipoHabitacion int
as
begin
	begin tryF
        delete from TipoHabitacion
        where IdTipoHabitacion = @IdTipoHabitacion
        
        select 1 as resultado
    end try
	begin catch
		select 
			error_number() as NumeroError,
			error_message() as MensajeError
    end catch
end

-- registrar comodidad a tipo de habitaci�n
create procedure RegistrarComodidadHabitacion
    @IdComodidad int,
    @IdTipoHabitacion int
as
begin
	begin try
		if not exists (select 1 from ComodidadHabitacion 
                      where IdComodidad = @IdComodidad and IdTipoHabitacion = @IdTipoHabitacion)
		begin 
			insert to ComodidadHabitacion (
                IdComodidad,
                IdTipoHabitacion
            )
            values (
                @IdComodidad,
                @IdTipoHabitacion
            )

            select scope_identity() as IdComodidadHabitacion
        end
		else
		begin
            select -1 as IdComodidadHabitacion
        end
    end try
    begin catch
		select 
			error_number() as NumeroError,
			error_message() as MensajeError
	end catch
end

--consultar todas las comodidades de habitaciones
create procedure ConsultarComodidadesHabitaciones
as
begin 
	select 
        ch.IdComodidadHabitacion,
        ch.IdComodidad,
        c.NombreComodidad,
        c.descripcion as descripcionComodidad,
        ch.IdTipoHabitacion,
        th.NombreTipoHabitacion
    from ComodidadHabitacion ch
    inner join Comodidad c on ch.IdComodidad = c.IdComodidad
    inner join TipoHabitacion th on ch.IdTipoHabitacion = th.IdTipoHabitacion
end

--consultar comodidades por tipo de habitaci�n
create procedure ConsultarComodidadesPorTipoHabitacion
    @IdTipoHabitacion int
as
begin	
	select
        ch.IdComodidadHabitacion,
        ch.IdComodidad,
        c.NombreComodidad,
        c.descripcion
    from ComodidadHabitacion ch
    inner join Comodidad c on ch.IdComodidad = c.IdComodidad
    where ch.IdTipoHabitacion = @IdTipoHabitacion
end

-- Eliminar comodidad de habitaci�n
create procedure EliminarComodidadHabitacion
    @IdComodidadHabitacion int
as 
begin
	begin try
		delete from ComodidadHabitacion
        where IdComodidadHabitacion = @IdComodidadHabitacion
        
        select 1 as resultado 
	end try
	begin catch
		select 
			error_number() as NumeroError,
			error_message() as MensajeError
	end catch
end

--Tabla FotoHabitacion
--agregar foto de la habitacion
create procedure AgregarFotoHabitacion
    @IdTipoHabitacion int,
    @Foto image
as
begin 
	begin try
		insert into FotoHabitacion (IdTipoHabitacion, Foto)
        values (@IdTipoHabitacion, @Foto)

		select scope_identity() as IdFotoHabitacion
	end try
	begin catch
		select 
			error_number() as NumeroError,
			error_message() as MensajeError
	end catch
end

--consultar todas las fotos
create procedure ConsultarTodasFotosHabitacion
as 
begin
	select  
        IdFotoHabitacion,
        IdTipoHabitacion,
        Foto
    from FotoHabitacion
end

--consultar fotos por tipo de habitaci�n
create procedure ConsultarFotosPorTipoHabitacion
    @IdTipoHabitacion int
as 
begin
	select
        IdFotoHabitacion,
        Foto
    from FotoHabitacion
    where IdTipoHabitacion = @IdTipoHabitacion
end

--actualizar la foto habitacion
create procedure ActualizarFotoHabitacion
    @IdFotoHabitacion int,
    @Foto image
as 
begin 
	begin try
		update FotoHabitacion
		set Foto = @Foto
		where @IdFotoHabitacion = @IdFotoHabitacion

		select 1 as resultado
	end try
	begin catch
		select
			error_number() as NumeroError,
			error_message() as MensajeError
	end catch
end

--eliminar foto de habitacion
create procedure EliminarFotoHabitacion
    @IdFotoHabitacion int
as
begin
	begin try 
		delete from FotaHabitacion
		where @IdFotoHabitacion = @IdFotoHabitacion

		select 1 as resultado
	end try
	begin catch
		select
			error_number() as NumeroError,
			error_message() as MensajeError
	end catch
end

--Tabla Habitacion
--registrar la habitacion
create procedure RegistrarHabitacion
    @NumeroHabitacion int,
    @IdTipoHabitacion int,
    @IdHospedaje int,
    @CantidadPersonas int
as 
begin
	begin try
		if not exists (select 1 from Habitacion 
                      where NumeroHabitacion = @NumeroHabitacion 
                      and IdHospedaje = @IdHospedaje)
        begin
			insert into Habitacion (
                NumeroHabitacion,
                IdTipoHabitacion,
                IdHospedaje,
                CantidadPersonas
            )
            values (
                @NumeroHabitacion,
                @IdTipoHabitacion,
                @IdHospedaje,
                @CantidadPersonas
            )

			select scope_identity() as IdHabitacion
		end 
		else
		begin
			select -1 as IdHabitacion
		end
	end try
	begin catch
		select
			error_number() as NumeroError,
			error_message() as MensajeError
	end catch
end

--consultar todas las habitaciones
create procedure ConsultarTodasHabitaciones
as 
begin
	select
        h.IdHabitacion,
        h.NumeroHabitacion,
        h.IdTipoHabitacion,
        th.NombreTipoHabitacion,
        h.IdHospedaje,
        hp.NombreHospedaje,
        h.CantidadPersonas
    from Habitacion h
	inner join TipoHabitacion th on h.IdTipoHabitacion = th.IdTipoHabitacion
    inner join Hospedaje hp on h.IdHospedaje = hp.IdHospedaje
end

--consultar habitaci�n por ID
create procedure ConsultarHabitacionPorId
    @IdHabitacion int
as
begin
	select 
        h.IdHabitacion,
        h.NumeroHabitacion,
        h.IdTipoHabitacion,
        th.NombreTipoHabitacion,
        h.IdHospedaje,
        hp.NombreHospedaje,
        h.CantidadPersonas
    from Habitacion h
    inner join TipoHabitacion th in h.IdTipoHabitacion = th.IdTipoHabitacion
    inner join Hospedaje hp on h.IdHospedaje = hp.IdHospedaje
    where h.IdHabitacion = @IdHabitacion
end

--consultar habitaciones por hospedaje
create procedure ConsultarHabitacionesPorHospedaje
    @IdHospedaje int
as 
begin
	select
        h.IdHabitacion,
        h.NumeroHabitacion,
        h.IdTipoHabitacion,
        th.NombreTipoHabitacion,
        h.CantidadPersonas
    from Habitacion h
    inner join TipoHabitacion th on h.IdTipoHabitacion = th.IdTipoHabitacion
    where h.IdHospedaje = @IdHospedaje
    order by h.NumeroHabitacion
end

--actualizar la habitacion
create procedure ActualizarHabitacion
    @IdHabitacion int,
    @NumeroHabitacion int,
    @IdTipoHabitacion int,
    @CantidadPersonas int
as
begin
	begin try
		declare @IdHospedaje int
		select @IdHospedaje = @IdHospedaje from Habitacion where @IdHabitacion = @IdHabitacion
		
		if not exists (select 1 from Habitacion 
                      where NumeroHabitacion = @NumeroHabitacion 
                      and IdHospedaje = @IdHospedaje
                      and IdHabitacion <> @IdHabitacion)

        begin
			update Habitacion set
                NumeroHabitacion = @NumeroHabitacion,
                IdTipoHabitacion = @IdTipoHabitacion,
                CantidadPersonas = @CantidadPersonas
            where IdHabitacion = @IdHabitacion
            
            select 1 as resultado
		end 
		else
		begin
			select -1 as resultado
		end
    end try
	begin catch
		select
			error_number() as NumeroError,
			error_message() as MensajeError
	end catch
end

--eliminar habitacion
create procedure EliminarHabitacion
    @IdHabitacion int
as
begin
	begin try
		delete from Habitacion
		where @IdHabitacion = @IdHabitacion

		select 1 as resultado
	end try
	begin catch
		select
			error_number() as NumeroError,
			error_message() as MensajeError
	end catch
end

--Tabla Cliente
--registrar cliente
create procedure ConsultarCliente
    @IdentificacionCliente varchar(20),
    @PrimerApellido varchar(50),
    @SegundoApellido varchar(50),
    @Nombre varchar(50),
    @CorreoElectronico varchar(100),
    @FechaNacimiento date,
    @TipoIdentidad int,
    @PaisResidencia int
as
begin
	begin try
		if not exists (select 1 from Cliente where IdentificacionCliente = @IdentificacionCliente)
		begin
			if not exists (select 1 from Cliente where CorreoElectronico = @CorreoElectronico)
            begin
				insert into Cliente(
                    IdentificacionCliente,
                    PrimerApellido,
                    SegundoApellido,
                    Nombre,
                    CorreoElectronico,
                    FechaNacimiento,
                    TipoIdentidad,
                    PaisResidencia
                )
                values (
                    @IdentificacionCliente,
                    @PrimerApellido,
                    @SegundoApellido,
                    @Nombre,
                    @CorreoElectronico,
                    @FechaNacimiento,
                    @TipoIdentidad,
                    @PaisResidencia
                )
                
				
                select scope_identity() as IdCliente
			end
			else
			begin
				select -1 as IdCliente
			end
        end
		else
		begin
			select -1 as IdCliente
		end 
	end try
	begin catch
		select
			error_number() as NumeroError,
			error_message() as MensajeError
	end catch
end

--consultar todos los clientes
create procedure ConsultarTodosClientes
as
begin
    select 
        c.IdCliente,
        c.IdentificacionCliente,
        c.PrimerApellido,
        c.SegundoApellido,
        c.Nombre,
        concat(c.Nombre, ' ', c.PrimerApellido, ' ', c.SegundoApellido) as NombreCompleto,
        c.CorreoElectronico,
        c.FechaNacimiento,
        datediff(year, c.FechaNacimiento, getdate()) as Edad,
        c.TipoIdentidad,
        ti.NombreTipoIdentidad,
        c.PaisResidencia,
        p.NombrePais
    from Cliente c
    inner join TipoIdentidad ti on c.TipoIdentidad = ti.IdTipoIdentidad
    inner join Pais p on c.PaisResidencia = p.IdPais
end

--consultar cliente por ID
create procedure ConsultarClientePorId
    @IdCliente int
as
begin
    select 
        c.IdCliente,
        c.IdentificacionCliente,
        c.PrimerApellido,
        c.SegundoApellido,
        c.Nombre,
        concat(c.Nombre, ' ', c.PrimerApellido, ' ', c.SegundoApellido) as NombreCompleto,
        c.CorreoElectronico,
        c.FechaNacimiento,
        datediff(year, c.FechaNacimiento, getdate()) as Edad,
        c.TipoIdentidad,
        ti.NombreTipoIdentidad,
        c.PaisResidencia,
        p.NombrePais
    from Cliente c
    inner join TipoIdentidad ti on c.TipoIdentidad = ti.IdTipoIdentidad
    inner join Pais p on c.PaisResidencia = p.IdPais
    where c.IdCliente = @IdCliente
end

--consultarclientes por nombre o apellido
create procedure ConsultarClientesPorNombre
    @Busqueda varchar(100)
as
begin
	select
        c.IdCliente,
        c.IdentificacionCliente,
        c.PrimerApellido,
        c.SegundoApellido,
        c.Nombre,
        concat(c.Nombre, ' ', c.PrimerApellido, ' ', c.SegundoApellido) as NombreCompleto,
        c.CorreoElectronico,
        c.FechaNacimiento
    from Cliente c
    where c.Nombre like '%' + @Busqueda + '%'
       or c.PrimerApellido like '%' + @Busqueda + '%'
       or c.SegundoApellido like '%' + @Busqueda + '%'
end

create procedure ActualizarCliente
    @IdCliente int,
    @IdentificacionCliente varchar(20),
    @PrimerApellido varchar(50),
    @SegundoApellido varchar(50),
    @Nombre varchar(50),
    @CorreoElectronico varchar(100),
    @FechaNacimiento date,
    @TipoIdentidad int,
    @PaisResidencia int
as
begin
    begin try
        if not exists(select 1 from Cliente 
                      where IdentificacionCliente = @IdentificacionCliente 
                      and IdCliente <> @IdCliente)
        begin
            if not exists(select 1 from Cliente 
                          where CorreoElectronico = @CorreoElectronico 
                          and IdCliente <> @IdCliente)
            begin
               update Cliente set
                    IdentificacionCliente = @IdentificacionCliente,
                    PrimerApellido = @PrimerApellido,
                    SegundoApellido = @SegundoApellido,
                    Nombre = @Nombre,
                    CorreoElectronico = @CorreoElectronico,
                    FechaNacimiento = @FechaNacimiento,
                    TipoIdentidad = @TipoIdentidad,
                    PaisResidencia = @PaisResidencia
                where IdCliente = @IdCliente
                
                select 1 as resultado 
            end
            else
            begin
                select -2 as resultado 
            end
        end
        else
        begin
            select -1 as resultado 
        end
    end try
    begin catch
        select 
            error_number() as NumeroError,
            error_message() as MensajeError
    end catch
end

create procedure EliminarCliente
    @IdCliente int
as
begin
    begin try
        delete from TelefonoCliente where IdCliente = @IdCliente
        
        delete from Cliente where IdCliente = @IdCliente
        
        select 1 as resultado 
    end try
    begin catch
        select 
            error_number() as NumeroError,
            error_message() as MensajeError
    end catch
end

--Tabla TelefonoCliente
--registrar el telefono del cliente
create procedure ResgistrarTelefonoCliente
    @IdCliente int,
    @NumeroTelefono varchar(20),
    @TipoTelefono varchar(20)
as
begin
    begin try
        if not exists (select 1 from TelefonoCliente 
                      where IdCliente = @IdCliente 
                      and NumeroTelefono = @NumeroTelefono)
        begin
            insert into TelefonoCliente (
                IdCliente,
                NumeroTelefono,
                TipoTelefono
            )
            values (
                @IdCliente,
                @NumeroTelefono,
                @TipoTelefono
            )
            
            select scope_identity() as IdTelefonoCliente
        end
        else
        begin
            select -1 as IdTelefonoCliente
        end
    end try
    begin catch
        select 
            error_number() as NumeroError,
            error_message() as MensajeError
    end catch
end

--consultar todos los telefonos de un cliente
create procedure ConsultarTelefonosCliente
    @IdCliente int
as
begin
    select 
        IdTelefonoCliente,
        NumeroTelefono,
        TipoTelefono
    from TelefonoCliente
    where IdCliente = @IdCliente
    order by 
        case TipoTelefono
            when 'Movil' then 1
            when 'Casa' then 2
            when 'Trabajo' then 3
            else 4
        end
end

--actualizar el telefono del cliente
create procedure ActualizarTelefonoCliente
    @IdTelefonoCliente int,
    @NumeroTelefono varchar(20),
    @TipoTelefono varchar(20)
as
begin
    begin try
        declare @IdCliente int
        select @IdCliente = IdCliente from TelefonoCliente where IdTelefonoCliente = @IdTelefonoCliente
        
        if not exists (select 1 from TelefonoCliente 
                      where IdCliente = @IdCliente 
                      and NumeroTelefono = @NumeroTelefono
                      and IdTelefonoCliente <> @IdTelefonoCliente)
        begin
           update TelefonoCliente set
                NumeroTelefono = @NumeroTelefono,
                TipoTelefono = @TipoTelefono
            where IdTelefonoCliente = @IdTelefonoCliente
            
            select 1 as resultado
        end
        else
        begin
            select -1 as resultado 
        end
    end try
    begin catch
        select 
            error_number() as NumeroError,
            error_message() as MensajeError
    end catch
end

--eliminar telefono de cliente
create procedure EliminarTelefonoCliente
    @IdTelefonoCliente int
as
begin
    begin try
        delete from TelefonoCliente
        where IdTelefonoCliente = @IdTelefonoCliente
        
        select 1 as resultado 
    end try
    begin catch
        select 
            error_number() as NumeroError,
            error_message() as MensajeError
    end catch
end

--Tabla Facturacion
--registrar reservacion
create procedure RegistrarReservacion
    @Numeroreserva varchar(12),
    @IdHabitacion int,
    @CantidadPersonas int,
    @IdCliente int,
    @FechaIngreso date,
    @Fechasalida date,
    @HoraIngreso time,
    @Horasalida time,
    @PoseeVehiculo bit = 0
as
begin
    begin try
        if not exists (
            select 1 from Reservacion 
            where IdHabitacion = @IdHabitacion
            and (
                (@FechaIngreso between FechaIngreso and Fechasalida) or
                (@Fechasalida between FechaIngreso and Fechasalida) or
                (FechaIngreso between @FechaIngreso and @Fechasalida)
            )
        )
        begin
            insert into Reservacion (
                Numeroreserva,
                IdHabitacion,
                CantidadPersonas,
                IdCliente,
                FechaIngreso,
                Fechasalida,
                HoraIngreso,
                Horasalida,
                PoseeVehiculo
            )
            values (
                @Numeroreserva,
                @IdHabitacion,
                @CantidadPersonas,
                @IdCliente,
                @FechaIngreso,
                @Fechasalida,
                @HoraIngreso,
                @Horasalida,
                @PoseeVehiculo
            )
            
            select scope_identity() as IdReserva
        end
        else
        begin
            select -1 as IdReserva 
        end
    end try
    begin catch
        select 
            error_number() as NumeroError,
            error_message() as MensajeError
    end catch
end

--consultar todas las reservaciones
create procedure ConsultarTodasReservaciones
as
begin
    select 
        r.IdReserva,
        r.Numeroreserva,
        r.IdHabitacion,
        h.NumeroHabitacion,
        th.NombreTipoHabitacion,
        hp.NombreHospedaje,
        r.CantidadPersonas,
        r.IdCliente,
        c.Nombre + ' ' + c.PrimerApellido as NombreCliente,
        r.FechaIngreso,
        r.Fechasalida,
        datediff(day, r.FechaIngreso, r.Fechasalida) as Noches,
        r.HoraIngreso,
        r.Horasalida,
        r.PoseeVehiculo
    from Reservacion r
    inner join Habitacion h on r.IdHabitacion = h.IdHabitacion
    inner join TipoHabitacion th on h.IdTipoHabitacion = th.IdTipoHabitacion
    inner join Hospedaje hp on h.IdHospedaje = hp.IdHospedaje
    inner join Cliente c on r.IdCliente = c.IdCliente
end

--consultar reservación por ID
create procedure ConsultarReservacionPorId
    @IdReserva int
as
begin
    select 
        r.IdReserva,
        r.Numeroreserva,
        r.IdHabitacion,
        h.NumeroHabitacion,
        th.NombreTipoHabitacion,
        hp.NombreHospedaje,
        r.CantidadPersonas,
        r.IdCliente,
        c.Nombre + ' ' + c.PrimerApellido as NombreCliente,
        r.FechaIngreso,
        r.Fechasalida,
        datediff(day, r.FechaIngreso, r.Fechasalida) as Noches,
        r.HoraIngreso,
        r.Horasalida,
        r.PoseeVehiculo
    from Reservacion r
    inner join Habitacion h on r.IdHabitacion = h.IdHabitacion
    inner join TipoHabitacion th on h.IdTipoHabitacion = th.IdTipoHabitacion
    inner join Hospedaje hp on h.IdHospedaje = hp.IdHospedaje
    inner join Cliente c on r.IdCliente = c.IdCliente
    where r.IdReserva = @IdReserva
end

--consultar reservaciones por cliente
create procedure ConsultarReservacionesPorCliente
    @IdCliente int
as
begin
    select 
        r.IdReserva,
        r.Numeroreserva,
        r.IdHabitacion,
        h.NumeroHabitacion,
        th.NombreTipoHabitacion,
        r.FechaIngreso,
        r.Fechasalida,
        datediff(day, r.FechaIngreso, r.Fechasalida) as Noches,
        r.PoseeVehiculo,
        case 
            when r.FechaIngreso > getdate() then 'Pendiente'
            when getdate() between r.FechaIngreso and r.Fechasalida then 'Activa'
            else 'Finalizada'
        end as Estado
    from Reservacion r
    inner join Habitacion h on r.IdHabitacion = h.IdHabitacion
    inner join TipoHabitacion th on h.IdTipoHabitacion = th.IdTipoHabitacion
    where r.IdCliente = @IdCliente
    order by r.FechaIngreso desc
end

--consultar reservaciones por rango de fechas
create procedure ConsultarReservacionesPorFecha
    @FechaInicio date,
    @FechaFin date
as
begin
    select 
        r.IdReserva,
        r.Numeroreserva,
        r.IdHabitacion,
        h.NumeroHabitacion,
        r.IdCliente,
        c.Nombre + ' ' + c.PrimerApellido as NombreCliente,
        r.FechaIngreso,
        r.Fechasalida,
        datediff(day, r.FechaIngreso, r.Fechasalida) as Noches,
        r.PoseeVehiculo
    from Reservacion r
    inner join Habitacion h on r.IdHabitacion = h.IdHabitacion
    inner join Cliente c on r.IdCliente = c.IdCliente
    where r.FechaIngreso between @FechaInicio and @FechaFin
       or r.Fechasalida between @FechaInicio and @FechaFin
    order by r.FechaIngreso
end

--actualizar la reservacion
create procedure ActualizarReservacion
    @IdReserva int,
    @IdHabitacion int,
    @CantidadPersonas int,
    @FechaIngreso date,
    @Fechasalida date,
    @HoraIngreso time,
    @Horasalida time,
    @PoseeVehiculo bit
as
begin
    begin try
        if not exists (
            select 1 from Reservacion 
            where IdHabitacion = @IdHabitacion
            and IdReserva <> @IdReserva
            and (
                (@FechaIngreso between FechaIngreso and Fechasalida) or
                (@Fechasalida between FechaIngreso and Fechasalida) or
                (FechaIngreso between @FechaIngreso and @Fechasalida)
            )
        )
        begin
           update Reservacion set
                IdHabitacion = @IdHabitacion,
                CantidadPersonas = @CantidadPersonas,
                FechaIngreso = @FechaIngreso,
                Fechasalida = @Fechasalida,
                HoraIngreso = @HoraIngreso,
                Horasalida = @Horasalida,
                PoseeVehiculo = @PoseeVehiculo
            where IdReserva = @IdReserva
            
            select 1 as resultado 
        end
        else
        begin
            select -1 as resultado 
        end
    end try
    begin catch
        select 
            error_number() as NumeroError,
            error_message() as MensajeError
    end catch
end

--eliminar reservacion
create procedure EliminarReservacion
    @IdReserva int
as
begin
    begin try
        if not exists (select 1 from Facturacion where IdReserva = @IdReserva)
        begin
            delete from Reservacion
            where IdReserva = @IdReserva
            
            select 1 as resultado 
        end
        else
        begin
            select -1 as resultado 
        end
    end try
    begin catch
        select 
            error_number() as NumeroError,
            error_message() as MensajeError
    end catch
end

--Tabla Facturacion
--registrar factura
create procedure RegistrarFacturacion
    @NumeroFacturacion varchar(12),
    @IdReserva int,
    @IdTipoPago int,
    @CantidadNoches int = null,
    @ImporteTotal decimal(10,2) = null
as
begin
    begin try
        if not exists (select 1 from Facturacion where IdReserva = @IdReserva)
        begin
            if @CantidadNoches is null or @ImporteTotal is null
            begin
                declare @FechaIngreso date, @Fechasalida date, @Precionoche decimal(10,2)
                
                select 
                    @FechaIngreso = r.FechaIngreso,
                    @Fechasalida = r.Fechasalida,
                    @Precionoche = th.Precio
                from Reservacion r
                inner join Habitacion h on r.IdHabitacion = h.IdHabitacion
                inner join TipoHabitacion th on h.IdTipoHabitacion = th.IdTipoHabitacion
                where r.IdReserva = @IdReserva
                
                set @CantidadNoches = datediff(day, @FechaIngreso, @Fechasalida)
                set @ImporteTotal = @CantidadNoches * @Precionoche
            end
            
            insert into Facturacion (
                NumeroFacturacion,
                IdReserva,
                FechaEmision,
                CantidadNoches,
                ImporteTotal,
                IdTipoPago
            )
            values (
                @NumeroFacturacion,
                @IdReserva,
                getdate(),
                @CantidadNoches,
                @ImporteTotal,
                @IdTipoPago
            )
            
            select scope_identity() as IdFactura
        end
        else
        begin
            select -1 as IdFactura 
        end
    end try
    begin catch
        select 
            error_number() as NumeroError,
            error_message() as MensajeError
    end catch
end

--consultar todas las facturas
create procedure ConsultarTodasFacturas
as
begin
    select 
        f.IdFactura,
        f.NumeroFacturacion,
        f.IdReserva,
        r.Numeroreserva,
        f.FechaEmision,
        f.CantidadNoches,
        f.ImporteTotal,
        f.IdTipoPago,
        tp.NombreTipoPago,
        c.Nombre + ' ' + c.PrimerApellido as NombreCliente,
        h.NumeroHabitacion,
        hp.NombreHospedaje
    from Facturacion f
    inner join Reservacion r on f.IdReserva = r.IdReserva
    inner join TipoPago tp on f.IdTipoPago = tp.IdTipoPago
    inner join Cliente c on r.IdCliente = c.IdCliente
    inner join Habitacion h on r.IdHabitacion = h.IdHabitacion
    inner join Hospedaje hp on h.IdHospedaje = hp.IdHospedaje
end

--cosultar factura por ID
create procedure ConsultarFacturaPorId
    @IdFactura int
as
begin
    select 
        f.IdFactura,
        f.NumeroFacturacion,
        f.IdReserva,
        r.Numeroreserva,
        f.FechaEmision,
        f.CantidadNoches,
        f.ImporteTotal,
        f.IdTipoPago,
        tp.NombreTipoPago,
        c.Nombre + ' ' + c.PrimerApellido as NombreCliente,
        c.IdentificacionCliente,
        h.NumeroHabitacion,
        th.NombreTipoHabitacion,
        hp.NombreHospedaje,
        r.FechaIngreso,
        r.Fechasalida,
        r.PoseeVehiculo
    from Facturacion f
    inner join Reservacion r on f.IdReserva = r.IdReserva
    inner join TipoPago tp on f.IdTipoPago = tp.IdTipoPago
    inner join Cliente c on r.IdCliente = c.IdCliente
    inner join Habitacion h on r.IdHabitacion = h.IdHabitacion
    inner join TipoHabitacion th on h.IdTipoHabitacion = th.IdTipoHabitacion
    inner join Hospedaje hp on h.IdHospedaje = hp.IdHospedaje
    where f.IdFactura = @IdFactura
end

--consultar facturas por cliente
create procedure ConsultarFacturasPorCliente
    @IdCliente int
as
begin
    select 
        f.IdFactura,
        f.NumeroFacturacion,
        f.FechaEmision,
        f.ImporteTotal,
        tp.NombreTipoPago,
        r.Numeroreserva,
        h.NumeroHabitacion,
        th.NombreTipoHabitacion,
        r.FechaIngreso,
        r.Fechasalida
    from Facturacion f
    inner join Reservacion r on f.IdReserva = r.IdReserva
    inner join TipoPago tp on f.IdTipoPago = tp.IdTipoPago
    inner join Habitacion h on r.IdHabitacion = h.IdHabitacion
    inner join TipoHabitacion th on h.IdTipoHabitacion = th.IdTipoHabitacion
    where r.IdCliente = @IdCliente
    order by f.FechaEmision desc
end

--consultar facturas por rango de fechas
create procedure ConsultarFacturasPorFecha
    @FechaInicio date,
    @FechaFin date
as
begin
    select 
        f.IdFactura,
        f.NumeroFacturacion,
        f.FechaEmision,
        f.ImporteTotal,
        tp.NombreTipoPago,
        c.Nombre + ' ' + c.PrimerApellido as NombreCliente,
        h.NumeroHabitacion,
        hp.NombreHospedaje
    from Facturacion f
    inner join Reservacion r on f.IdReserva = r.IdReserva
    inner join TipoPago tp on f.IdTipoPago = tp.IdTipoPago
    inner join Cliente c on r.IdCliente = c.IdCliente
    inner join Habitacion h on r.IdHabitacion = h.IdHabitacion
    inner join Hospedaje hp on h.IdHospedaje = hp.IdHospedaje
    where f.FechaEmision between @FechaInicio and @FechaFin
    order by f.FechaEmision
end


create procedure ActualizarFacturacion
    @IdFactura int,
    @IdTipoPago int,
    @CantidadNoches int = null,
    @ImporteTotal decimal(10,2) = null
as
begin
    begin try
        if @CantidadNoches is null or @ImporteTotal is null
        begin
            declare @FechaIngreso date, @Fechasalida date, @Precionoche decimal(10,2)
            
            select 
                @FechaIngreso = r.FechaIngreso,
                @Fechasalida = r.Fechasalida,
                @Precionoche = th.Precio
            from Facturacion f
            inner join Reservacion r on f.IdReserva = r.IdReserva
            inner join Habitacion h on r.IdHabitacion = h.IdHabitacion
            inner join TipoHabitacion th on h.IdTipoHabitacion = th.IdTipoHabitacion
            where f.IdFactura = @IdFactura
            
            set @CantidadNoches = datediff(day, @FechaIngreso, @Fechasalida)
            set @ImporteTotal = @CantidadNoches * @Precionoche
        end
        
       update Facturacion set
            IdTipoPago = @IdTipoPago,
            CantidadNoches = @CantidadNoches,
            ImporteTotal = @ImporteTotal
        where IdFactura = @IdFactura
        
        select 1 as resultado 
    end try
    begin catch
        select 
            error_number() as NumeroError,
            error_message() as MensajeError
    end catch
end

--eliminar facturacion 
create procedure EliminarFacturacion
    @IdFactura int
as
begin
    begin try
        delete from Facturacion
        where IdFactura = @IdFactura
        
        select 1 as resultado 
    end try
    begin catch
        select 
            error_number() as NumeroError,
            error_message() as MensajeError
    end catch
end


--Tabla EmpresaRecreativa
--registrar empresa recreativa
create procedure RegistrarEmpresaRecreativa
    @CedulaJuridicaEmpresa varchar(20),
    @NombreEmpresas varchar(50),
    @CorreoElectronico varchar(100),
    @NombrePersonal varchar(150),
    @NumeroTelefono varchar(20)
as
begin
    begin try
        if not exists (select 1 from EmpresaRecreativa where CedulaJuridicaEmpresa = @CedulaJuridicaEmpresa)
        begin
            if not exists (select 1 from EmpresaRecreativa where CorreoElectronico = @CorreoElectronico)
            begin
                insert into EmpresaRecreativa (
                    CedulaJuridicaEmpresa,
                    NombreEmpresas,
                    CorreoElectronico,
                    NombrePersonal,
                    NumeroTelefono
                )
                values (
                    @CedulaJuridicaEmpresa,
                    @NombreEmpresas,
                    @CorreoElectronico,
                    @NombrePersonal,
                    @NumeroTelefono
                )
                
                select scope_identity() as IdEmpresaRecreativa
            end
            else
            begin
                select -2 as IdEmpresaRecreativa 
            end
        end
        else
        begin
            select -1 as IdEmpresaRecreativa 
        end
    end try
    begin catch
        select 
            error_number() as NumeroError,
            error_message() as MensajeError
    end catch
end

--consultar todas las empresas recreativas
create procedure ConsultarEmpresasRecreativas
as
begin
    select 
        IdEmpresaRecreativa,
        CedulaJuridicaEmpresa,
        NombreEmpresas,
        CorreoElectronico,
        NombrePersonal,
        NumeroTelefono
    from EmpresaRecreativa
    order by NombreEmpresas
end

--consultar empresa por ID
create procedure ConsultarEmpresaRecreativaPorId
    @IdEmpresaRecreativa int
as
begin
    select 
        IdEmpresaRecreativa,
        CedulaJuridicaEmpresa,
        NombreEmpresas,
        CorreoElectronico,
        NombrePersonal,
        NumeroTelefono
    from EmpresaRecreativa
    where IdEmpresaRecreativa = @IdEmpresaRecreativa
end

--consultar empresas por nombre
create procedure ConsultarEmpresasRecreativas
    @Nombre varchar(50)
as
begin
    select 
        IdEmpresaRecreativa,
        CedulaJuridicaEmpresa,
        NombreEmpresas,
        CorreoElectronico,
        NombrePersonal,
        NumeroTelefono
    from EmpresaRecreativa
    where NombreEmpresas like '%' + @Nombre + '%'
    order by NombreEmpresas
end

--actualizar empresa recreativa
create procedure ActualizarEmpresaRecreativa
    @IdEmpresaRecreativa int,
    @NombreEmpresas varchar(50),
    @CorreoElectronico varchar(100),
    @NombrePersonal varchar(150),
    @NumeroTelefono varchar(20)
as
begin
    begin try
        if not exists (select 1 from EmpresaRecreativa 
                      where CorreoElectronico = @CorreoElectronico 
                      and IdEmpresaRecreativa <> @IdEmpresaRecreativa)
        begin
           update EmpresaRecreativa set
                NombreEmpresas = @NombreEmpresas,
                CorreoElectronico = @CorreoElectronico,
                NombrePersonal = @NombrePersonal,
                NumeroTelefono = @NumeroTelefono
            where IdEmpresaRecreativa = @IdEmpresaRecreativa
            
            select 1 as resultado 
        end
        else
        begin
            select -1 as resultado 
        end
    end try
    begin catch
        select 
            error_number() as NumeroError,
            error_message() as MensajeError
    end catch
end

--eliminar empresa recreativo
create procedure EliminarEmpresaRecreativa
    @IdEmpresaRecreativa int
as
begin
    begin try
        if not exists (select 1 from Empresaservicio where IdEmpresaRecreativa = @IdEmpresaRecreativa)
        begin
            delete from EmpresaRecreativa
            where IdEmpresaRecreativa = @IdEmpresaRecreativa
            
            select 1 as resultado 
        end
        else
        begin
            select -1 as resultado
        end
    end try
    begin catch
        select 
            error_number() as NumeroError,
            error_message() as MensajeError
    end catch
end

--Tabla Empresaservicio
--registrar empresa servicio
create procedure RegistrarEmpresaservicio
    @CostoAdicional decimal(10,2),
    @descripcion text,
    @IdServicio int,
    @IdEmpresaRecreativa int
as
begin
    begin try
        if not exists (select 1 from Empresaservicio 
                      where IdServicio = @IdServicio 
                      and IdEmpresaRecreativa = @IdEmpresaRecreativa)
        begin
            insert into Empresaservicio (
                CostoAdicional,
                descripcion,
                IdServicio,
                IdEmpresaRecreativa
            )
            values (
                @CostoAdicional,
                @descripcion,
                @IdServicio,
                @IdEmpresaRecreativa
            )
            
            select scope_identity() as IdEmpresaservicio
        end
        else
        begin
            select -1 as IdEmpresaservicio 
        end
    end try
    begin catch
        select 
            error_number() as NumeroError,
            error_message() as MensajeError
    end catch
end

--consultar todos los servicios de empresas
create procedure ConsultarEmpresaservicios
as
begin
    select 
        es.IdEmpresaservicio,
        es.CostoAdicional,
        es.descripcion,
        es.IdServicio,
        ts.NombreServicio,
        es.IdEmpresaRecreativa,
        er.NombreEmpresas
    from Empresaservicio es
    inner join TipoServicio ts on es.IdServicio = ts.IdServicio
    inner join EmpresaRecreativa er on es.IdEmpresaRecreativa = er.IdEmpresaRecreativa
end

--consultar servicios por empresa
create procedure ConsultarServiciosPorEmpresa
    @IdEmpresaRecreativa int
as
begin
    select 
        es.IdEmpresaservicio,
        es.CostoAdicional,
        es.descripcion,
        es.IdServicio,
        ts.NombreServicio,
        case 
            when es.CostoAdicional is null then ts.PrecioBase
            else ts.PrecioBase + es.CostoAdicional
        end as PrecioTotal
    from Empresaservicio es
    inner join TipoServicio ts on es.IdServicio = ts.IdServicio
    where es.IdEmpresaRecreativa = @IdEmpresaRecreativa
end

--consultar empresas por tipo de servicio
create procedure ConsultarEmpresasPorServicio
    @IdServicio int
as
begin
    select 
        es.IdEmpresaservicio,
        es.CostoAdicional,
        es.descripcion,
        er.IdEmpresaRecreativa,
        er.NombreEmpresas,
        er.NombrePersonal,
        er.NumeroTelefono,
        case 
            when es.CostoAdicional is null then ts.PrecioBase
            else ts.PrecioBase + es.CostoAdicional
        end as PrecioTotal
    from Empresaservicio es
    inner join EmpresaRecreativa er on es.IdEmpresaRecreativa = er.IdEmpresaRecreativa
    inner join TipoServicio ts on es.IdServicio = ts.IdServicio
    where es.IdServicio = @IdServicio
end

--actualizar empresaservicio
create procedure ActualizarEmpresaservicio
    @IdEmpresaservicio int,
    @CostoAdicional decimal(10,2),
    @descripcion text
as
begin
    begin try
       update Empresaservicio set
            CostoAdicional = @CostoAdicional,
            descripcion = @descripcion
        where IdEmpresaservicio = @IdEmpresaservicio
        
        select 1 as resultado 
    end try
    begin catch
        select 
            error_number() as NumeroError,
            error_message() as MensajeError
    end catch
end

--eliminar empresa servicio
create procedure EliminarEmpresaservicio
    @IdEmpresaservicio int
as
begin
    begin try
        delete from Empresaservicio
        where IdEmpresaservicio = @IdEmpresaservicio
        
        select 1 as resultado
    end try
    begin catch
        select 
            error_number() as NumeroError,
            error_message() as MensajeError
    end catch
end

--Tabla EmpresaActividad
--registrar empresa actividad
create procedure RegistrarEmpresaActividad
    @Precio decimal(10,2),
    @MaximoParticipantes int,
    @MinimoParticipantes int,
    @Duracion int,
    @descripcion text = null,
    @Horarios text = null,
    @IdActividad int,
    @IdEmpresaRecreativa int
as
begin
    begin try
        if not exists (select 1 from EmpresaActividad 
                      where IdActividad = @IdActividad 
                      and IdEmpresaRecreativa = @IdEmpresaRecreativa)
        begin
            insert into EmpresaActividad (
                Precio,
                MaximoParticipantes,
                MinimoParticipantes,
                Duracion,
                descripcion,
                Horarios,
                IdActividad,
                IdEmpresaRecreativa
            )
            values (
                @Precio,
                @MaximoParticipantes,
                @MinimoParticipantes,
                @Duracion,
                @descripcion,
                @Horarios,
                @IdActividad,
                @IdEmpresaRecreativa
            )
            
            select scope_identity() as IdEmpresaActividad
        end
        else
        begin
            select -1 as IdEmpresaActividad 
        end
    end try
    begin catch
        select 
            error_number() as NumeroError,
            error_message() as MensajeError
    end catch
end

--consultar todas las actividades de empresas
create procedure ConsultarEmpresaActividades
as
begin
    select 
        ea.IdEmpresaActividad,
        ea.Precio,
        ea.MaximoParticipantes,
        ea.MinimoParticipantes,
        ea.Duracion,
        ea.descripcion,
        ea.Horarios,
        ea.IdActividad,
        ta.NombreActividad,
        ea.IdEmpresaRecreativa,
        er.NombreEmpresas
    from EmpresaActividad ea
    inner join TipoActividad ta on ea.IdActividad = ta.IdActividad
    inner join EmpresaRecreativa er on ea.IdEmpresaRecreativa = er.IdEmpresaRecreativa
end

--consultar actividades por empresa
create procedure ConsultarActividadesPorEmpresa
    @IdEmpresaRecreativa int
as
begin
    select 
        ea.IdEmpresaActividad,
        ea.Precio,
        ea.MaximoParticipantes,
        ea.MinimoParticipantes,
        ea.Duracion,
        ea.descripcion,
        ea.Horarios,
        ea.IdActividad,
        ta.NombreActividad
    from EmpresaActividad ea
    inner join TipoActividad ta on ea.IdActividad = ta.IdActividad
    where ea.IdEmpresaRecreativa = @IdEmpresaRecreativa
end

--consultar empresas por tipo de actividad
create procedure ConsultarEmpresasPorActividad
    @IdActividad int
as
begin
    select 
        ea.IdEmpresaActividad,
        ea.Precio,
        ea.MaximoParticipantes,
        ea.MinimoParticipantes,
        er.IdEmpresaRecreativa,
        er.NombreEmpresas,
        er.NombrePersonal,
        er.NumeroTelefono
    from EmpresaActividad ea
    inner join EmpresaRecreativa er on ea.IdEmpresaRecreativa = er.IdEmpresaRecreativa
    where ea.IdActividad = @IdActividad
end

--consultar actividad específica
create procedure ConsultarEmpresaActividadPorId
    @IdEmpresaActividad int
as
begin
    select 
        ea.IdEmpresaActividad,
        ea.Precio,
        ea.MaximoParticipantes,
        ea.MinimoParticipantes,
        ea.Duracion,
        ea.descripcion,
        ea.Horarios,
        ea.IdActividad,
        ta.NombreActividad,
        ea.IdEmpresaRecreativa,
        er.NombreEmpresas
    from EmpresaActividad ea
    inner join TipoActividad ta on ea.IdActividad = ta.IdActividad
    inner join EmpresaRecreativa er on ea.IdEmpresaRecreativa = er.IdEmpresaRecreativa
    where ea.IdEmpresaActividad = @IdEmpresaActividad
end

--actualizar empresa actividad
create procedure ActualizarEmpresaActividad
    @IdEmpresaActividad int,
    @Precio decimal(10,2),
    @MaximoParticipantes int,
    @MinimoParticipantes int,
    @Duracion int,
    @descripcion text = null,
    @Horarios text = null
as
begin
    begin try
       update EmpresaActividad set
            Precio = @Precio,
            MaximoParticipantes = @MaximoParticipantes,
            MinimoParticipantes = @MinimoParticipantes,
            Duracion = @Duracion,
            descripcion = @descripcion,
            Horarios = @Horarios
        where IdEmpresaActividad = @IdEmpresaActividad
        
        select 1 as resultado
    end try
    begin catch
        select 
            error_number() as NumeroError,
            error_message() as MensajeError
    end catch
end

--eliminar empresa actividad
create procedure EliminarEmpresaActividad
    @IdEmpresaActividad int
as
begin
    begin try
        delete from EmpresaActividad
        where IdEmpresaActividad = @IdEmpresaActividad
        
        select 1 as resultado 
    end try
    begin catch
        select 
            error_number() as NumeroError,
            error_message() as MensajeError
    end catch
end

--registrar direccion empresa
create procedure RegistrarDireccionEmpresa
    @IdEmpresaRecreativa int,
    @SenasExactas varchar(255),
    @Provincia int,
    @Canton varchar(50),
    @Distrito varchar(50)
as
begin
    begin try
        if not exists (select 1 from DireccionEmpresa where IdEmpresaRecreativa = @IdEmpresaRecreativa)
        begin
            insert into DireccionEmpresa (
                IdEmpresaRecreativa,
                SenasExactas,
                Provincia,
                Canton,
                Distrito
            )
            values (
                @IdEmpresaRecreativa,
                @SenasExactas,
                @Provincia,
                @Canton,
                @Distrito
            )
            
            select scope_identity() as IdDireccionEmpresa
        end
        else
        begin
            select -1 as IdDireccionEmpresa 
        end
    end try
    begin catch
        select 
            error_number() as NumeroError,
            error_message() as MensajeError
    end catch
end

--consultar todas las direcciones de empresas
create procedure ConsultarDireccionesEmpresas
as
begin
    select 
        de.IdDireccionEmpresa,
        de.IdEmpresaRecreativa,
        er.NombreEmpresas,
        de.SenasExactas,
        de.Provincia,
        p.NombreProvincia,
        de.Canton,
        de.Distrito
    from DireccionEmpresa de
    inner join EmpresaRecreativa er on de.IdEmpresaRecreativa = er.IdEmpresaRecreativa
    inner join Provincia p on de.Provincia = p.IdProvincia
end

--consultar dirección por empresa
create procedure ConsultarDireccionPorEmpresa
    @IdEmpresaRecreativa int
as
begin
    select 
        de.IdDireccionEmpresa,
        de.SenasExactas,
        de.Provincia,
        p.NombreProvincia,
        de.Canton,
        de.Distrito
    from DireccionEmpresa de
    inner join Provincia p on de.Provincia = p.IdProvincia
    where de.IdEmpresaRecreativa = @IdEmpresaRecreativa
end

--consultar empresas por provincia
create procedure ConsultarEmpresasPorProvincia
    @IdProvincia int
as
begin
    select 
        er.IdEmpresaRecreativa,
        er.NombreEmpresas,
        er.CorreoElectronico,
        er.NumeroTelefono,
        de.SenasExactas,
        de.Canton,
        de.Distrito
    from DireccionEmpresa de
    inner join EmpresaRecreativa er on de.IdEmpresaRecreativa = er.IdEmpresaRecreativa
    where de.Provincia = @IdProvincia
end

--actualizar direccion empresa
create procedure ActualizarDireccionEmpresa
    @IdDireccionEmpresa int,
    @SenasExactas varchar(255),
    @Provincia int,
    @Canton varchar(50),
    @Distrito varchar(50)
as
begin
    begin try
       update DireccionEmpresa set
            SenasExactas = @SenasExactas,
            Provincia = @Provincia,
            Canton = @Canton,
            Distrito = @Distrito
        where IdDireccionEmpresa = @IdDireccionEmpresa
        
        select 1 as resultado 
    end try
    begin catch
        select 
            error_number() as NumeroError,
            error_message() as MensajeError
    end catch
end

--eliminar direccion empresa
create procedure EliminarDireccionEmpresa
    @IdDireccionEmpresa int
as
begin
    begin try
        delete from DireccionEmpresa
        where IdDireccionEmpresa = @IdDireccionEmpresa
        
        select 1 as resultado
    end try
    begin catch
        select 
            error_number() as NumeroError,
            error_message() as MensajeError
    end catch
end