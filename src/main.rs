use bevy::prelude::*;
use game_state::GameState;

mod game;
mod game_state;
mod title;

fn main() {
    App::new()
        .insert_resource(ClearColor(Color::BLACK))
        .add_plugins(DefaultPlugins)
        .add_plugin(title::plugin::TitlePlugin)
        .add_plugin(game::plugin::GamePlugin)
        .add_startup_system(setup_camera)
        .add_state(GameState::Title)
        .run();
}

fn setup_camera(mut commands: Commands) {
    commands.spawn_bundle(OrthographicCameraBundle::new_2d());
}
