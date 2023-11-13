# Database

> [!IMPORTANT]
> This data model will grow. I am intentially keeping it bare bones. I want to build out the Minimum Viable Product (MVP). I want something in our hands by the end of the month.

This is the database architecture for the Local platform. It is using a relational data model.

Here is a top level list of the different data models present in this document.

- [Locale](#locale)
- [User](#user)
- [Organization](#organization)
- [Board](#board)
- [Post](#post)

## Locale

This is the top level of the entire application. Since the app is meant to be a community organizing app everything by definition falls into a locale. The will be as granular as a city or town, no more or less.

```sql
    CREATE TABLE Locales (
        locale_id INTEGER PRIMARY KEY,
        display_name TEXT NOT NULL,
        city TEXT,
        region TEXT,
        country TEXT,
        zipcode TEXT
    );
```

## User

Before you can get to any of the application's data you must look at the user. These are where all of the data is generated and where all of the interactions are happening. I've split out User and Person conceptually. A User is a concept of someone that is interacting with the system. Think email, password, etc... A Person is the actualy personality that is interacting with the data. This is the person that has a display name, bio, etc...

```sql
    CREATE TABLE UserTypes (
        user_type_id INTEGER PRIMARY KEY,
        type_name TEXT NOT NULL,
        type_description TEXT
    );

    CREATE TABLE Users (
        user_id INTEGER PRIMARY KEY,
        email_address TEXT NOT NULL UNIQUE,
        username TEXT NOT NULL UNIQUE,
        password_hash TEXT NOT NULL,
        user_type TEXT
    );

    CREATE TABLE Persons (
        person_id INTEGER PRIMARY KEY,
        user_id INTEGER NOT NULL,
        display_name TEXT NOT NULL,
        home_locale TEXT NOT NULL,
        bio TEXT,
        FOREIGN KEY (user_id) REFERENCES User(user_id),
    );
```

## Organization

The next highest level is an organization. This will be to conceptually group boards together. The default organization is the Local org. This has an ID of 1 and will always be the default. Eventually there could be organzations for Schools, Comanies, etc... These will be denoted by Org types.

```sql
CREATE TABLE OrgTypes (
    org_type_id INTEGER PRIMARY KEY,
    type_name TEXT NOT NULL,
    type_description TEXT
);

CREATE TABLE Organizations (
    org_id INTEGER PRIMARY KEY,
    org_slug TEXT NOT NULL UNIQUE,
    org_name TEXT NOT NULL,
    org_type TEXT NOT NULL,
    parent_locale INTEGER NOT NULL,
    FOREIGN KEY (parent_local) REFERENCES Locale(local_id),
    FOREIGN KEY (org_type) REFERENCES OrgType(org_type_id)
);
```

## Board

One level below Organization and the core concept of Local is the Board type. This type acts as the glue that holds all of the different concept together. Boards, like the concept of a bulliten board, contain posts relating to the theme of the board.

```sql
CREATE TABLE BoardUserType (
    board_type_id INTEGER PRIMARY KEY,
    type_name TEXT NOT NULL,
    type_description TEXT
)

CREATE TABLE Boards (
    board_id INTEGER PRIMARY KEY,
    board_slug TEXT NOT NULL UNIQUE,
    board_name TEXT NOT NULL,
    board_description TEXT,
    parent_org INTEGER,
    FOREIGN KEY (parent_org) REFERENCES Organization(org_id)
)

CREATE TABLE BoardUser (
    board_id INTEGER NOT NULL,
    user_id INTEGER NOT NULL,
    board_user_type INTEGER NOT NULL,
    PRIMARY KEY (board_id, user_id),
    FOREIGN KEY (board_id) REFERENCES Board(board_id),
    FOREIGN KEY (user_id) REFERENCES User(user_id),
    FOREIGN KEY (board_user_type) REFERENCES BoardUserType()
)

```

## Post

A post is the atomic unit for Local. All a post has is a title and a body. It is mean to be a quick and easy description of the information you want to convey. Eventually we will extend this, but for now it will be simple.

```sql
CREATE TABLE Posts (
    post_id INTEGER PRIMARY KEY,
    post_slug TEXT NOT NULL UNIQUE,
    post_title TEXT NOT NULL,
    post_body TEXT NOT NULL,
    parent_board INTEGER,
    FOREIGN KEY (parent_board) REFERENCES Board(board_id)
)
```
