use crate::game_state::GameState;
use bevy::prelude::*;

pub struct GamePlugin;

#[derive(Component, Debug)]
struct Runner;

impl Plugin for GamePlugin {
    fn build(&self, app: &mut App) {
        app.add_system_set(SystemSet::on_enter(GameState::InGame).with_system(setup))
            .add_system_set(SystemSet::on_update(GameState::InGame).with_system(update));
    }
}

fn setup(mut commands: Commands) {
    commands
        .spawn_bundle(SpriteBundle {
            sprite: Sprite {
                color: Color::rgb(1., 1., 1.),
                custom_size: Some(Vec2::new(100.0, 100.0)),
                ..Default::default()
            },
            ..Default::default()
        })
        .insert(Runner);
}

fn update(keys: Res<Input<KeyCode>>, mut query: Query<&mut Transform, With<Runner>>) {
    let mut direction = Vec2::ZERO;

    if keys.any_pressed([KeyCode::Up, KeyCode::W]) {
        direction.y += 1.0;
    }
    if keys.any_pressed([KeyCode::Down, KeyCode::S]) {
        direction.y -= 1.0;
    }
    if keys.any_pressed([KeyCode::Right, KeyCode::D]) {
        direction.x += 1.0;
    }
    if keys.any_pressed([KeyCode::Left, KeyCode::A]) {
        direction.x -= 1.0;
    }
    if direction == Vec2::ZERO {
        return;
    }

    let move_speed = 30.0;
    let move_delta = (direction.normalize() * move_speed).extend(0.);

    for mut transform in query.iter_mut() {
        transform.translation += move_delta;
    }
}
