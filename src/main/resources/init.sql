create table if not exists `authority` (name varchar(16) not null, primary key (name)) engine=InnoDB;
create table if not exists `hibernate_sequence` (next_val bigint) engine=InnoDB;
insert into `hibernate_sequence` values ( 1 );
create table if not exists  `note` (id bigint not null, created_date datetime not null, last_modified_date datetime, content varchar(255), title varchar(255), created_by_user_id bigint, last_modified_by_user_id bigint, primary key (id)) engine=InnoDB;
create table if not exists  note_attached_files (note_id bigint not null, attached_files_id varchar(255) not null) engine=InnoDB;
create table if not exists  received_file (id varchar(255) not null, file_group varchar(255), original_file_name varchar(255), received_date datetime, stored_name varchar(255), primary key (id)) engine=InnoDB;
create table if not exists  `user` (id bigint not null, account_non_expired TINYINT not null, account_non_locked TINYINT not null, activation_key varchar(255), active TINYINT not null, avatar longblob, credentials_non_expired TINYINT not null, email varchar(254) not null, first_name varchar(30) not null, last_name varchar(30), password_hash varchar(60), reset_key varchar(255), unique_id varchar(20) not null, primary key (id)) engine=InnoDB;
create table if not exists user_authority (user_id bigint not null, authority_name varchar(16) not null, primary key (user_id, authority_name)) engine=InnoDB;
alter table note_attached_files drop index UK_scsarmvyi2g14k38a7qadt79o;
alter table note_attached_files add constraint UK_scsarmvyi2g14k38a7qadt79o unique (attached_files_id);
alter table user drop index UK_ob8kqyqqgmefl0aco34akdtpe;
alter table user add constraint UK_ob8kqyqqgmefl0aco34akdtpe unique (email);
alter table user drop index UK_5euv5mbx798s42kudj86n1gar;
alter table user add constraint UK_5euv5mbx798s42kudj86n1gar unique (unique_id);
alter table note add constraint FKi1ipy2ipk091srw344ebuy8id foreign key (created_by_user_id) references user (id);
alter table note add constraint FK19ut222fjfeyik0o6dppuf4re foreign key (last_modified_by_user_id) references user (id);
alter table note_attached_files add constraint FK97jin5fy8ulbg2dftgh21dn6 foreign key (attached_files_id) references received_file (id);
alter table note_attached_files add constraint FK6sj645npyvavxf4big3swe0wu foreign key (note_id) references note (id);
alter table user_authority add constraint FK6ktglpl5mjosa283rvken2py5 foreign key (authority_name) references authority (name);
alter table user_authority add constraint FKpqlsjpkybgos9w2svcri7j8xy foreign key (user_id) references user (id);