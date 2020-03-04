------------
-- V 0_9_7
------------
alter table ocpp_tag
    drop column in_transaction;

------------
-- V 0_9_8
------------
alter table transaction
    add event_timestamp timestamp;

-- for backwards compatibility and existing data
update transaction
set event_timestamp = start_timestamp;

-- now that the values are set, add constraints
alter table transaction
    alter column event_timestamp set not null;

alter table transaction
    alter column event_timestamp set default current_timestamp;

create type transaction_stop_event_actor as enum ('station', 'manual');

create table transaction_stop
(
    transaction_pk  int          not null,
    event_timestamp timestamp    not null default current_timestamp,
    event_actor     transaction_stop_event_actor,
    stop_timestamp  timestamp    not null default current_timestamp,
    stop_value      varchar(255) not null,
    stop_reason     varchar(255),
    primary key (transaction_pk, event_timestamp)
);

alter table transaction_stop
    add constraint FK_transaction_stop_transaction_pk
        foreign key (transaction_pk) references transaction (transaction_pk) on delete cascade on update no action;

-- move data from transaction table to transaction_stop table
insert into transaction_stop(transaction_pk, event_timestamp, event_actor, stop_timestamp, stop_value, stop_reason)
select t.transaction_pk, t.stop_timestamp, 'station', t.stop_timestamp, t.stop_value, t.stop_reason
from transaction t
where t.stop_value is not null
  and t.stop_timestamp is not null;

-- now that we moved the data, drop redundant columns
alter table transaction
    drop column stop_timestamp,
    drop column stop_value,
    drop column stop_reason;

-- rename old table
alter table transaction
    rename to transaction_start;

-- reconstruct `transaction` as a view for database changes to be transparent to java app
-- select LATEST stop transaction events when joining
create or replace view transaction as
select tx1.transaction_pk,
       tx1.connector_pk,
       tx1.id_tag,
       tx1.event_timestamp as start_event_timestamp,
       tx1.start_timestamp,
       tx1.start_value,
       tx2.event_actor     as stop_event_actor,
       tx2.event_timestamp as stop_event_timestamp,
       tx2.stop_timestamp,
       tx2.stop_value,
       tx2.stop_reason
from transaction_start tx1
         left join (
    select s1.*
    from transaction_stop s1
    where s1.event_timestamp =
          (select max(event_timestamp) from transaction_stop s2 where s1.transaction_pk = s2.transaction_pk)
    group by s1.transaction_pk, s1.event_timestamp) tx2
                   on tx1.transaction_pk = tx2.transaction_pk;


------------
-- V 0_9_9
------------

alter table ocpp_tag
    add max_active_transaction_count integer not null default 1;

update ocpp_tag
set max_active_transaction_count = 0
where blocked = true;

alter table ocpp_tag
    drop column blocked;

-- recreate this view, with derived "blocked" field to be transparent to java app
create or replace view ocpp_tag_activity as
SELECT ocpp_tag.*,
       coalesce(tx_activity.active_transaction_count, 0)                              as active_transaction_count,
       case when (active_transaction_count > 0) then true else false end              as in_transaction,
       case when (ocpp_tag.max_active_transaction_count = 0) then true else false end as blocked
from ocpp_tag
         left join
     (select id_tag, count(id_tag) as active_transaction_count
      from transaction
      where stop_timestamp is null
        and stop_value is null
      group by id_tag) tx_activity
     on ocpp_tag.id_tag = tx_activity.id_tag;

------------
-- V 1_0_0
------------
create type transaction_stop_failed_event_actor as enum ('station', 'manual');

create table transaction_stop_failed
(
    transaction_pk  integer,
    event_timestamp timestamp not null default current_timestamp,
    event_actor     transaction_stop_failed_event_actor,
    stop_timestamp  timestamp not null default current_timestamp,
    stop_value      varchar(255),
    stop_reason     varchar(255),
    fail_reason     text
);

------------
-- V 1_0_1
------------
alter table connector_meter_value
    alter column value type text;

------------
-- V 1_0_2
------------
alter table charge_box
    add column registration_status varchar(255) not null default 'Accepted';
