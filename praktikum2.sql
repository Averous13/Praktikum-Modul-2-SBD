--1

CREATE SCHEMA `servis_mobil_antera` ;

CREATE TABLE `servis_mobil_antera`.`pelanggan`(
    p_id char(16) not null,
    p_nama varchar(60) not null,
    p_no_telp varchar(15) not null,
    p_email varchar(256),
    p_alamat varchar(100) not null,
    PRIMARY KEY(p_id)
);

CREATE TABLE `servis_mobil_antera`.`mekanik`(
    mk_id char(6) not null,
    mk_nama varchar(60) not null,
    PRIMARY KEY(mk_id));

    
CREATE TABLE `servis_mobil_antera`.`suku_cadang`(
    sc_id char(7) not null,
    sc_nama varchar(120) not null,
    sc_deskripsi varchar(100) not null,
    sc_harga float(10,2) not null,
    PRIMARY KEY(sc_id)
);

CREATE TABLE `servis_mobil_antera`.`mobil`(
    mb_vin char(17) not null,
    mb_merk varchar(20) not null,
    mb_tipe varchar(30) not null,
    mb_tahun int not null,
    mb_warna varchar(20) notu null,
    mb_p_id  char 16,
    PRIMARY KEY(mb_vin),
    CONSTRAINT mb_p_id_fk FOREIGN KEY(mb_p_id) REFERENCES pelanggan(p_id)
);


CREATE TABLE `servis_mobil_antera`.`tiket_servis`(
    ts_id char(8) not null,
    ts_waktu_masuk timestamp not null default current_timestamp,
    ts_waktu_keluar timestamp default current_timestamp,
    ts_deskripsi varchar(400) not null,
    ts_komentar varchar(400),
    ts_p_id char(16) not null,
    ts_mb_vin char(17) not null,
    CONSTRAINT ts_p_id_FK FOREIGN KEY(ts_p_id) REFERENCES pelanggan(p_id),
    CONSTRAINT ts_mb_vin_FK  FOREIGN KEY(ts_mb_vin) REFERENCES mobil(mb_vin),
    PRIMARY KEY(ts_id)
);

CREATE TABLE `servis_mobil_antera`.`mekanik_servis`(
    mksv_mk_id char(6) not null,
    mksv_ts_id char(8) not null,
    PRIMARY KEY(mksv_mk_id,mksv_ts_id),
    CONSTRAINT mksv_mk_id_FK FOREIGN KEY(mksv_mk_id) REFERENCES mekanik(mk_id),
    CONSTRAINT mksv_ts_id_FK FOREIGN KEY(mksv_ts_id) REFERENCES tiket_servis(ts_id)
);

CREATE TABLE `servis_mobil_antera`.`suku_cadang_servis`(
    scsv_ts_id char(8) not null,
    scsv_sc_id char(7) not null,
    PRIMARY KEY(scsv_ts_id, scsv_sc_id),
    CONSTRAINT scsv_sc_id_FK FOREIGN KEY(scsv_sc_id) REFERENCES suku_cadang(sc_id),
    CONSTRAINT scsv_ts_id_FK FOREIGN KEY(scsv_ts_id) REFERENCES tiket_servis(ts_id)  
);

--2
CREATE TABLE `servis_mobil_antera`.`supplier`(
    sp_id CHAR (6) not null,
    sp_nama VARCHAR (60) not null,
    sp_no_telp VARCHAR (15) not null,
    sp_email VARCHAR (256) not null,
    sp_alamat VARCHAR (100) not null,
    PRIMARY KEY(sp_id)
);

--3
ALTER TABLE `servis_mobil_antera`.`mekanik` 
RENAME TO  `servis_mobil_antera`.`pegawai` ;

CREATE TABLE `servis_mobil_antera`.`posisi`(
    ps_id CHAR(6) not null,
    ps_nama VARCHAR(15) not null,
    PRIMARY KEY(ps_id)
);

ALTER TABLE `servis_mobil_antera`.`pegawai`
ADD ps_nama_id char(6) not null, 
ADD CONSTRAINT pg_ps_id_FK FOREIGN KEY(ps_nama_id) REFERENCES posisi(ps_id);   

--4
ALTER TABLE `servis_mobil_antera`.`pegawai`
DROP constraint pg_ps_id_FK;

DROP TABLE `servis_mobil_antera`.`posisi`

ALTER TABLE `servis_mobil_antera`.`pegawai` 
ADD COLUMN `mk_posisi` VARCHAR(20),

--5

INSERT INTO `servis_mobil_antera`.`pelanggan` (`p_id`, `p_nama`, `p_no_telp`, `p_email`, `p_alamat`) VALUES ('3225011201880002', 'Andy Williams', '62123456789', 'andy@gmail.com', 'Jl. Apel no 1');
INSERT INTO `servis_mobil_antera`.`pelanggan` (`p_id`, `p_nama`, `p_no_telp`, `p_email`, `p_alamat`) VALUES ('3525010706950001', 'Marshall Paul', '621451871011', 'paulan@gmail.com', 'Jl. Jeruk no 12');
INSERT INTO `servis_mobil_antera`.`pelanggan` (`p_id`, `p_nama`, `p_no_telp`, `p_email`, `p_alamat`) VALUES ('3525016005920002', 'Kazuya Tanaka', '62190129190', 'tanaka@gmail.com', 'Jl. JKT no 48');
INSERT INTO `servis_mobil_antera`.`pelanggan` (`p_id`, `p_nama`, `p_no_telp`, `p_alamat`) VALUES ('3975311107780001', 'Budi Prutomo', '621545458901', 'Jl. Nanas no 45Jl. Nanas no 45');
INSERT INTO `servis_mobil_antera`.`pelanggan` (`p_id`, `p_nama`, `p_no_telp`, `p_alamat`) VALUES ('3098762307810002', 'Razai Ambudi', '621898989102', 'Jl. Mangga no 2');

INSERT INTO `servis_mobil_antera`.`mobil` (`mb_vin`, `mb_merk`, `mb_tipe`, `mb_tahun`, `mb_warna`, `mb_p_id`) VALUES ('JN8AZ1MW4BW678706', 'Nissan', 'Murano', '2011', 'biru', '3525010706950001');
INSERT INTO `servis_mobil_antera`.`mobil` (`mb_vin`, `mb_merk`, `mb_tipe`, `mb_tahun`, `mb_warna`, `mb_p_id`) VALUES ('2LMTJ8JP0GSJ00175', 'Lincoln', 'MKX', '2016', 'merah', '3525016005920002');
INSERT INTO `servis_mobil_antera`.`mobil` (`mb_vin`, `mb_merk`, `mb_tipe`, `mb_tahun`, `mb_warna`, `mb_p_id`) VALUES ('ZFF76ZHT3E0201920', 'Ferrari', 'Ferrari', '2014', 'merah', '3975311107780001');
INSERT INTO `servis_mobil_antera`.`mobil` (`mb_vin`, `mb_merk`, `mb_tipe`, `mb_tahun`, `mb_warna`, `mb_p_id`) VALUES ('1HGCP26359A157554', 'Honda', 'Accord', '2009', 'hitam', '3225011201880002');
INSERT INTO `servis_mobil_antera`.`mobil` (`mb_vin`, `mb_merk`, `mb_tipe`, `mb_tahun`, `mb_warna`, `mb_p_id`) VALUES ('5YJSA1DN5CFP01785', 'Tesla', 'Model S', '2012', 'putih', '3098762307810002');

INSERT INTO `servis_mobil_antera`.`pegawai` (`mk_id`, `mk_nama`, `mk_posisi`) VALUES ('MK0001', 'Walter Jones', 'mekanik');
INSERT INTO `servis_mobil_antera`.`pegawai` (`mk_id`, `mk_nama`, `mk_posisi`) VALUES ('MK0002', 'Kentaki Veraid', 'kasir');
INSERT INTO `servis_mobil_antera`.`pegawai` (`mk_id`, `mk_nama`, `mk_posisi`) VALUES ('MK0003', 'Leo', 'mekanik');
INSERT INTO `servis_mobil_antera`.`pegawai` (`mk_id`, `mk_nama`, `mk_posisi`) VALUES ('MK0004', 'Reyhand Janita', 'pencuci');
INSERT INTO `servis_mobil_antera`.`pegawai` (`mk_id`, `mk_nama`, `mk_posisi`) VALUES ('MK0005', 'Elizabeth Alexandra', 'mekanik');

INSERT INTO `servis_mobil_antera`.`supplier` (`sp_id`, `sp_nama`, `sp_no_telp`, `sp_email`, `sp_alamat`) VALUES ('SP0001', 'Indotrading', '6282283741247', 'indotrading@rocketmail.com', 'Jl. Bambu no 5');
INSERT INTO `servis_mobil_antera`.`supplier` (`sp_id`, `sp_nama`, `sp_no_telp`, `sp_email`, `sp_alamat`) VALUES ('SP0002', 'Jayasinda', '628227428238', 'Jayasinda@yahoo.com', 'Jl. Padi no 12');
INSERT INTO `servis_mobil_antera`.`supplier` (`sp_id`, `sp_nama`, `sp_no_telp`, `sp_email`, `sp_alamat`) VALUES ('SP0003', 'SAS Autoparts', '6282212382311', 'sasparts@gmail.com', 'Jl. Sorghum no 24');


INSERT INTO `servis_mobil_antera`.`suku_cadang` (`sc_id`, `sc_nama`, `sc_deskripsi`, `sc_harga`) VALUES ('SC00001', 'Damper', 'Damper Per Belakang Original', '800000.00');
INSERT INTO `servis_mobil_antera`.`suku_cadang` (`sc_id`, `sc_nama`, `sc_deskripsi`, `sc_harga`) VALUES ('SC00002', 'Coil Ignition', 'Coil Ignition Denso Jepang', '550000.00');
INSERT INTO `servis_mobil_antera`.`suku_cadang` (`sc_id`, `sc_nama`, `sc_deskripsi`, `sc_harga`) VALUES ('SC00003', 'Selang Filter', 'Selang Filter Udara Original', '560000.00');
INSERT INTO `servis_mobil_antera`.`suku_cadang` (`sc_id`, `sc_nama`, `sc_deskripsi`, `sc_harga`) VALUES ('SC00004', 'Bushing', 'Bushing Upper Arm Original', '345000.00');
INSERT INTO `servis_mobil_antera`.`suku_cadang` (`sc_id`, `sc_nama`, `sc_deskripsi`, `sc_harga`) VALUES ('SC00005', 'Radiator Racing', 'Radiator Racing Kotorad Manual Diesel', '6750000.00');

INSERT INTO `servis_mobil_antera`.`tiket_servis` (`ts_id`, `ts_waktu_masuk`, `ts_waktu_keluar`, `ts_deskripsi`, `ts_komentar`, `ts_p_id`, `ts_mb_vin`) VALUES ('TS000001', '2023-11--06 08:00:00', '2023-11--06 16:30:00', 'Mobil mengalami', 'Saya sangat puas', '3098762307810002', '5YJSA1DN5CFP01785');
INSERT INTO `servis_mobil_antera`.`tiket_servis` (`ts_id`, `ts_waktu_masuk`, `ts_waktu_keluar`, `ts_deskripsi`, `ts_komentar`, `ts_p_id`, `ts_mb_vin`) VALUES ('TS000002', '2023-11--06 09:15:00', '2023-11--0617:45:00', 'Mesin mobil', 'Mesin mobil saya', '3975311107780001', 'ZFF76ZHT3E0201920');
INSERT INTO `servis_mobil_antera`.`tiket_servis` (`ts_id`, `ts_waktu_masuk`, `ts_waktu_keluar`, `ts_deskripsi`, `ts_komentar`, `ts_p_id`, `ts_mb_vin`) VALUES ('TS000003', '2023-11-06 10:30:00', '2023-11-06 18:15:00', 'Untuk', 'Mobil saya', '3525016005920002', '2LMTJ8JP0GSJ00175');
INSERT INTO `servis_mobil_antera`.`tiket_servis` (`ts_id`, `ts_waktu_masuk`, `ts_waktu_keluar`, `ts_deskripsi`, `ts_komentar`, `ts_p_id`, `ts_mb_vin`) VALUES ('TS000004', '2023-11--06 11:45:00', '2023-11-06 19:30:00', 'Mobil mengalami', 'Setelah', '3525010706950001', 'JN8AZ1MW4BW678706');
INSERT INTO `servis_mobil_antera`.`tiket_servis` (`ts_id`, `ts_waktu_masuk`, `ts_waktu_keluar`, `ts_deskripsi`, `ts_komentar`, `ts_p_id`, `ts_mb_vin`) VALUES ('TS000005', '2023-11--06 12:30:00', '2023-11--06 20:00:00', 'Mobil akan', 'Pemeliharaan', '3225011201880002', '1HGCP26359A157554');

INSERT INTO `servis_mobil_antera`.`mekanik_servis` (`mksv_mk_id`, `mksv_ts_id`) VALUES ('MK0005', 'TS000001');
INSERT INTO `servis_mobil_antera`.`mekanik_servis` (`mksv_mk_id`, `mksv_ts_id`) VALUES ('MK0003', 'TS000002');
INSERT INTO `servis_mobil_antera`.`mekanik_servis` (`mksv_mk_id`, `mksv_ts_id`) VALUES ('MK0004', 'TS000002');
INSERT INTO `servis_mobil_antera`.`mekanik_servis` (`mksv_mk_id`, `mksv_ts_id`) VALUES ('MK0005', 'TS000003');
INSERT INTO `servis_mobil_antera`.`mekanik_servis` (`mksv_mk_id`, `mksv_ts_id`) VALUES ('MK0003', 'TS000004');
INSERT INTO `servis_mobil_antera`.`mekanik_servis` (`mksv_mk_id`, `mksv_ts_id`) VALUES ('MK0001', 'TS000005');
INSERT INTO `servis_mobil_antera`.`mekanik_servis` (`mksv_mk_id`, `mksv_ts_id`) VALUES ('MK0005', 'TS000005');
INSERT INTO `servis_mobil_antera`.`mekanik_servis` (`mksv_mk_id`, `mksv_ts_id`) VALUES ('MK0004', 'TS000005');

INSERT INTO `servis_mobil_antera`.`suku_cadang_servis` (`scsv_ts_id`, `scsv_sc_id`) VALUES ('TS000001', 'SC00001');
INSERT INTO `servis_mobil_antera`.`suku_cadang_servis` (`scsv_ts_id`, `scsv_sc_id`) VALUES ('TS000001', 'SC00004');
INSERT INTO `servis_mobil_antera`.`suku_cadang_servis` (`scsv_ts_id`, `scsv_sc_id`) VALUES ('TS000002', 'SC00002');
INSERT INTO `servis_mobil_antera`.`suku_cadang_servis` (`scsv_ts_id`, `scsv_sc_id`) VALUES ('TS000003', 'SC00005');
INSERT INTO `servis_mobil_antera`.`suku_cadang_servis` (`scsv_ts_id`, `scsv_sc_id`) VALUES ('TS000004', 'SC00003');
INSERT INTO `servis_mobil_antera`.`suku_cadang_servis` (`scsv_ts_id`, `scsv_sc_id`) VALUES ('TS000005', 'SC00001');
INSERT INTO `servis_mobil_antera`.`suku_cadang_servis` (`scsv_ts_id`, `scsv_sc_id`) VALUES ('TS000005', 'SC00002');
INSERT INTO `servis_mobil_antera`.`suku_cadang_servis` (`scsv_ts_id`, `scsv_sc_id`) VALUES ('TS000005', 'SC00003');
INSERT INTO `servis_mobil_antera`.`suku_cadang_servis` (`scsv_ts_id`, `scsv_sc_id`) VALUES ('TS000005', 'SC00005');

--6
UPDATE `servis_mobil_antera`.`tiket_servis`
set ts_waktu_keluar = current_timestamp

--7
UPDATE `servis_mobil_antera`.`pelanggan`
set p_nama = "Andi Williams", p_email = "andi@bing.com", p_alamat = "Jl. Koreka no 15"
where p_id = 3225011201880002

--8
ALTER TABLE servis_mobil_antera.suku_cadang
ADD COLUMN sc_sp_id char(6),
ADD CONSTRAINT sc_sp_id_fk foreign key(sc_sp_id) REFERENCES supplier(sp_id) on update cascade on delete cascade;

UPDATE `servis_mobil_antera`.`suku_cadang` SET `sc_sp_id` = 'SP0002' WHERE (`sc_id` = 'SC00001');
UPDATE `servis_mobil_antera`.`suku_cadang` SET `sc_sp_id` = 'SP0002' WHERE (`sc_id` = 'SC00003');
UPDATE `servis_mobil_antera`.`suku_cadang` SET `sc_sp_id` = 'SP0003' WHERE (`sc_id` = 'SC00002');
UPDATE `servis_mobil_antera`.`suku_cadang` SET `sc_sp_id` = 'SP0003' WHERE (`sc_id` = 'SC00005');
UPDATE `servis_mobil_antera`.`suku_cadang` SET `sc_sp_id` = 'SP0001' WHERE (`sc_id` = 'SC00004');


--9
update `servis_mobil_antera`.`suku_cadang`
set sc_harga = sc_harga * (110/100)
where sc_harga > 500000

--10
INSERT INTO `servis_mobil_antera`.`tiket_servis` (`ts_id`, `ts_waktu_masuk`, `ts_deskripsi`, `ts_p_id`, `ts_mb_vin`) VALUES ('TS000006', '2023-11-10 09:05:00', '“Mobil mengalami kerusakan damper belakang. Terdapat kebocoran cairan hidrolik dan kondisi damper sudah aus. Kami akan mengganti damper belakang', '3525016005920002', '2LMTJ8JP0GSJ00175');

--11
UPDATE `servis_mobil_antera`.`tiket_servis` SET `ts_komentar` = 'kurang memuaskan karena meneumukan goresan kecil' WHERE (`ts_id` = 'TS000006');

ALTER TABLE `servis_mobil_antera`.`mekanik_servis` 
DROP FOREIGN KEY `mksv_mk_id_FK`;
ALTER TABLE `servis_mobil_antera`.`mekanik_servis` 
ADD CONSTRAINT `mksv_mk_id_FK`
  FOREIGN KEY (`mksv_mk_id`)
  REFERENCES `servis_mobil_antera`.`pegawai` (`mk_id`)
  ON DELETE CASCADE
  ON UPDATE CASCADE;

DELETE FROM servis_mobil_antera.pegawai WHERE pegawai.mk_nama = 'Walter Jones';


--12
DELETE  FROM servis_mobil_antera.mekanik_servis;
