use crate::game_state::GameState;
use bevy::prelude::*;

pub struct TitlePlugin;

impl Plugin for TitlePlugin {
    fn build(&self, app: &mut App) {
        app.add_system_set(SystemSet::on_enter(GameState::Title).with_system(setup))
            .add_system_set(SystemSet::on_update(GameState::Title).with_system(update))
            .add_system_set(SystemSet::on_exit(GameState::Title).with_system(cleanup));
    }
}

struct MenuEntity {
    start_button: Entity,
}

const BUTTON_COLOR_NORMAL: Color = Color::rgb(0.3, 0.3, 0.3);
const BUTTON_COLOR_HOVER: Color = Color::rgb(0.4, 0.4, 0.4);
const BUTTON_COLOR_PRESSED: Color = Color::rgb(0.6, 0.6, 0.6);

fn setup(mut commands: Commands, asset_server: Res<AssetServer>) {
    commands.spawn_bundle(UiCameraBundle::default());

    let start_button = commands
        .spawn_bundle(ButtonBundle {
            style: Style {
                size: Size::new(Val::Px(150.0), Val::Px(65.0)),
                margin: Rect::all(Val::Auto),
                justify_content: JustifyContent::Center,
                align_items: AlignItems::Center,
                ..Default::default()
            },
            color: BUTTON_COLOR_NORMAL.into(),
            ..Default::default()
        })
        .with_children(|parent| {
            parent.spawn_bundle(TextBundle {
                text: Text::with_section(
                    "PLAY",
                    TextStyle {
                        font: asset_server.load("fonts/mplus.ttf"),
                        font_size: 50.0,
                        color: Color::WHITE,
                    },
                    TextAlignment {
                        vertical: VerticalAlign::Center,
                        horizontal: HorizontalAlign::Center,
                    },
                ),
                ..Default::default()
            });
        })
        .id();

    commands.insert_resource(MenuEntity { start_button });
}

fn cleanup(mut commands: Commands, menu: Res<MenuEntity>) {
    commands.entity(menu.start_button).despawn_recursive()
}

fn update(
    mut state: ResMut<State<GameState>>,
    mut query: Query<(&Interaction, &mut UiColor), (Changed<Interaction>, With<Button>)>,
) {
    for (interaction, mut color) in query.iter_mut() {
        match *interaction {
            Interaction::Clicked => {
                *color = BUTTON_COLOR_PRESSED.into();
                state.set(GameState::InGame).unwrap();
            }
            Interaction::Hovered => {
                *color = BUTTON_COLOR_HOVER.into();
            }
            Interaction::None => {
                *color = BUTTON_COLOR_NORMAL.into();
            }
        }
    }
}
