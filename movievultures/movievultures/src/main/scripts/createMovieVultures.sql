create sequence hibernate_sequence start 1 increment 1;

    create table favorites (
        username int4 not null,
        movieId int4 not null
    );

    create table movie_cast (
        movieId int4 not null,
        actor varchar(255)
    );

    create table movie_directors (
        movieId int4 not null,
        director varchar(255)
    );

    create table movie_genres (
        movieId int4 not null,
        genre varchar(255)
    );

    create table movies (
        movieId int4 not null,
        date timestamp,
        eloRating float8 not null,
        plot text,
        title varchar(255),
        primary key (movieId)
    );

    create table recommendations (
        username int4 not null,
        movieId int4 not null
    );

    create table reviews (
        reviewId int4 not null,
        date timestamp,
        rating int4 not null,
        review varchar(255),
        movie_movieId int4,
        user_userId int4,
        primary key (reviewId)
    );

    create table users (
        userId int4 not null,
        email varchar(255),
        password varchar(255),
        username varchar(255),
        primary key (userId)
    );

    create table watchLater (
        username int4 not null,
        movieId int4 not null
    );

    alter table favorites 
        add constraint FKa3oceguw77uopk25jft7k408q 
        foreign key (movieId) 
        references movies;

    alter table favorites 
        add constraint FKgun9e0l2253lebhqp387fxq1m 
        foreign key (username) 
        references users;

    alter table movie_cast 
        add constraint FKkxueewcoqa0n9dfncqwuo9xuy 
        foreign key (movieId) 
        references movies;

    alter table movie_directors 
        add constraint FK8puh90w29yio5awsl64eh1nuk 
        foreign key (movieId) 
        references movies;

    alter table movie_genres 
        add constraint FKe09ck74qsi33na3rwp5k8pxwd 
        foreign key (movieId) 
        references movies;

    alter table recommendations 
        add constraint FKtq1gak1ljeqc4g0ors0uo2cjf 
        foreign key (movieId) 
        references movies;

    alter table recommendations 
        add constraint FKhf7tvhx572qvkijwn4lgewwm0 
        foreign key (username) 
        references users;

    alter table reviews 
        add constraint FK6ht4vun0bm0dd5iv8ap2ag4rh 
        foreign key (movie_movieId) 
        references movies;

    alter table reviews 
        add constraint FKnhfaav07nfun384llv7ipayhj 
        foreign key (user_userId) 
        references users;

    alter table watchLater 
        add constraint FK7xw9fn48nlav23nk8yaw7lhik 
        foreign key (movieId) 
        references movies;

    alter table watchLater 
        add constraint FK96tkdrdc9a655qng4se0ghtb1 
        foreign key (username) 
        references users;
