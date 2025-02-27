CREATE TABLE public.event_categories (
	id serial4 NOT NULL,
	"name" varchar NULL,
	display_order int4 NULL,
	CONSTRAINT "PK_EventCategories" PRIMARY KEY (id)
);

CREATE TABLE public.event_enrollments (
	id serial4 NOT NULL,
	id_event int4 NOT NULL,
	id_user int4 NOT NULL,
	description varchar NULL,
	registration_date_time timestamp NULL,
	attended bool NULL,
	observations varchar NULL,
	rating int4 NULL,
	CONSTRAINT "PK_EventEnrollments" PRIMARY KEY (id)
);

CREATE TABLE public.event_locations (
	id serial4 NOT NULL,
	id_location int4 NOT NULL,
	"name" varchar NULL,
	full_address varchar NULL,
	max_capacity varchar NOT NULL,
	latitude decimal NULL,
	longitude decimal NULL,
	id_creator_user int4 NOT NULL,
	CONSTRAINT "PK_EventLocations" PRIMARY KEY (id)
);

CREATE TABLE public.event_tags (
	id serial4 NOT NULL,
	id_event int4 NOT NULL,
	id_tag int4 NOT NULL,
	CONSTRAINT "PK_EventTags" PRIMARY KEY (id)
);

CREATE TABLE public.events (
	id serial4 NOT NULL,
	"name" varchar NULL,
	description varchar NULL,
	id_event_category int4 NULL,
	id_event_location int4 NULL,
	start_date timestamp NULL,
	duration_in_minutes int4 NOT NULL,
	price decimal NOT NULL,
	enabled_for_enrollment bool NULL,
	max_assistance int4 NOT NULL,
	id_creator_user int4 NOT NULL,
	CONSTRAINT "PK_Events" PRIMARY KEY (id)
);

CREATE TABLE public.locations (
	id serial4 NOT NULL,
	"name" varchar NULL,
	id_province int4 NOT NULL,
	latitude decimal NULL,
	longitude decimal NULL,
	CONSTRAINT "PK_Locations" PRIMARY KEY (id)
);

CREATE TABLE public.provinces (
	id serial4 NOT NULL,
	"name" varchar NULL,
	full_name varchar NULL,
	latitude decimal NULL,
	longitude decimal NULL,
	display_order int4 NULL,
	CONSTRAINT "PK_Provinces " PRIMARY KEY (id)
);

CREATE TABLE public.tags (
	id serial4 NOT NULL,
	"name" varchar NOT NULL,
	CONSTRAINT "PK_Tags" PRIMARY KEY (id)
);

CREATE TABLE public.users (
	id serial4 NOT NULL,
	first_name varchar NOT NULL,
	last_name varchar NOT NULL,
	username varchar NOT NULL,
	"password" varchar NOT NULL,
	CONSTRAINT "PK_Users" PRIMARY KEY (id)
);



INSERT INTO public.locations ("name", id_province, latitude, longitude) VALUES (N'Ciudad de Buenos Aires', 2, -34.608417510986328, -58.372135162353516);
INSERT INTO public.locations ("name", id_province, latitude, longitude) VALUES (N'Carhué', 6, -37.179481506347656, -62.759990692138672);
INSERT INTO public.locations ("name", id_province, latitude, longitude) VALUES (N'Colonia San Miguel Arcángel', 6, -37.449016571044922, -63.117156982421875);



INSERT INTO public.provinces (id, "name", full_name, latitude, longitude, display_order) VALUES (2, N'Ciudad Autónoma de Buenos Aires', N'Ciudad Autónoma de Buenos Aires', -34.61444091796875, -58.445877075195312, NULL);
INSERT INTO public.provinces (id, "name", full_name, latitude, longitude, display_order) VALUES (6, N'Buenos Aires', N'Provincia de Buenos Aires', -36.677391052246094, -60.558475494384766, NULL);
INSERT INTO public.provinces (id, "name", full_name, latitude, longitude, display_order) VALUES (10, N'Catamarca', N'Provincia de Catamarca', -27.335954666137695, -66.9478988647461, NULL);


INSERT INTO public.users (id, first_name, last_name, username, "password") VALUES (1, N'Pablo', N'Ulman', N'polshu@polshu.com.ar', N'pablito');
INSERT INTO public.users (id, first_name, last_name, username, "password") VALUES (2, N'Julian', N'Schiffer', N'schifferjulian@gmail.com', N'julian');

INSERT INTO public.event_locations (id_location,"name",full_address,max_capacity,latitude,longitude,id_creator_user) VALUES (1,'River','Av. Pres. Figueroa Alcorta 7597','84567',-34.5453,-58.4498,2);

INSERT INTO public.events ("name",description,id_event_category,id_event_location,start_date,duration_in_minutes,price,max_assistance,id_creator_user,enabled_for_enrollment) VALUES ('Taylor Swift','Un alto show',1,1,'2024-03-29 00:00:00',210,15500,120000,1,true);
INSERT INTO public.events ("name",description,id_event_category,id_event_location,start_date,duration_in_minutes,price,max_assistance,id_creator_user,enabled_for_enrollment) VALUES ('Taylor Swift','Un alto show',1,1,'2024-03-28 00:00:00',210,15500,120000,2,true);

INSERT INTO public.tags ("name") VALUES (N'pop');
INSERT INTO public.tags ("name") VALUES (N'rock');

INSERT INTO public.event_categories ("name", display_order) VALUES (N'Musica', 10);
INSERT INTO public.event_categories ("name", display_order) VALUES (N'Deportes', 20);
INSERT INTO public.event_categories ("name", display_order) VALUES (N'Soial', 30);

INSERT INTO public.event_tags (id_event, id_tag) VALUES (1, 1);
INSERT INTO public.event_tags (id_event, id_tag) VALUES (1, 2);
INSERT INTO public.event_tags (id_event, id_tag) VALUES (2, 1);
INSERT INTO public.event_tags (id_event, id_tag) VALUES (2, 2);

INSERT INTO public.event_enrollments (id_event,id_user,description,registration_date_time,observations,rating,attended) VALUES (2,1,'Alto Chow','2024-03-22 00:44:51.737126',NULL,5,true);
INSERT INTO public.event_enrollments (id_event,id_user,description,registration_date_time,observations,rating,attended) VALUES (2,2,NULL,'2024-03-22 00:44:51.737126',NULL,NULL,false);


ALTER TABLE event_enrollments ADD CONSTRAINT FK_event_enrollments_events FOREIGN KEY (id_event) REFERENCES events (id);
ALTER TABLE event_enrollments ADD CONSTRAINT FK_event_enrollments_users FOREIGN KEY(id_user) REFERENCES users (id);
ALTER TABLE event_locations ADD CONSTRAINT FK_event_locations_locations FOREIGN KEY(id_location) REFERENCES locations (id);
ALTER TABLE event_tags ADD CONSTRAINT FK_event_tags_events FOREIGN KEY(id_event) REFERENCES events (id);
ALTER TABLE event_tags ADD CONSTRAINT FK_event_tags_tags FOREIGN KEY(id_tag) REFERENCES tags (id);
ALTER TABLE events ADD CONSTRAINT FK_events_event_categories FOREIGN KEY(id_event_category) REFERENCES event_categories (id);
ALTER TABLE events ADD CONSTRAINT FK_events_event_locations FOREIGN KEY(id_event_location) REFERENCES event_locations (id);
ALTER TABLE events ADD CONSTRAINT FK_events_users FOREIGN KEY(id_creator_user) REFERENCES users (id);
ALTER TABLE locations ADD CONSTRAINT FK_locations_provinces FOREIGN KEY(id_province) REFERENCES provinces (id);