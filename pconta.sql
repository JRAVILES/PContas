alter table pcontas
    drop constraint FK_PCONTAS_REFERENCE_PCONTAS;

alter table pcontas
    drop constraint FK_PCONTAS_REFERENCE_COMPANHI;

/*==============================================================*/
/* Table: pcontas                                               */
/*==============================================================*/
create table pcontas (
   id                   SERIAL not null,
   cia_id               INT8                 not null,
   pai_id               INT8                 null,
   codigo               INT8                 null,
   descricao            VARCHAR(200)         null,
   created_at           DATE                 null,
   updated_at           DATE                 null,
   constraint PK_PCONTAS primary key (id)
);

/*==============================================================*/
/* Index: pcontas_pk                                            */
/*==============================================================*/
create unique index pcontas_pk on pcontas (
id
);

/*==============================================================*/
/* Index: reference_46_fk                                       */
/*==============================================================*/
create  index reference_46_fk on pcontas (
cia_id
);

/*==============================================================*/
/* Index: reference_233_fk                                      */
/*==============================================================*/
create  index reference_233_fk on pcontas (
pai_id
);

alter table pcontas
   add constraint FK_PCONTAS_REFERENCE_PCONTAS foreign key (pai_id)
      references pcontas (id)
      on delete restrict on update restrict;

alter table pcontas
   add constraint FK_PCONTAS_REFERENCE_COMPANHI foreign key (cia_id)
      references companhias (id);
