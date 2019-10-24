# GameOfLifeCheat

This is a live coding repo I did for Ruby Istanbul Meetup a while ago.

It implements core GameOfLife with pure struct and function logic, and shows a barebone glider pattern rendered via Phoenix Live View.

### Files to check for

Here are some interesting files to look up:

```
├── lib
│   ├── game_of_life_cheat
│   │   ├── application.ex
│   │   ├── cell.ex
│   │   ├── patterns.ex
│   │   └── world.ex
│   ├── game_of_life_cheat_web
│   │   ├── endpoint.ex
│   │   ├── gettext.ex
│   │   ├── live
│   │   │   └── game_live.ex
│   │   ├── router.ex
│   │   ├── templates
│   │   │   └── page
└── test
    ├── game_of_life_cheat
    │   ├── cell_test.exs
    │   ├── pattern_test.exs
    └── └── world_test.exs
```

### Getting Started

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix
