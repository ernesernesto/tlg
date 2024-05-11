// Begin Q4
void Game::addItemToPlayer(const std::string &recipient, uint16_t itemId) {
  Player *player = g_game.getPlayerByName(recipient);
  if (!player) {
    player = new Player(nullptr);
    if (!IOLoginData::loadPlayerByName(player, recipient)) {
      return;
    }
  }

  Item *item = Item::CreateItem(itemId);
  if (!item) {
    return;
  }

  g_game.internalAddItem(player->getInbox(), item, INDEX_WHEREEVER,
                         FLAG_NOLIMIT);

  if (player->isOffline()) {
    IOLoginData::savePlayer(player);
  }
}

// End Q4

// Answer 1
void Game::addItemToPlayer(const std::string &recipient, uint16_t itemId) {
  Player *player = g_game.getPlayerByName(recipient);
  if (!player) {
    player = new Player(nullptr);
    if (!IOLoginData::loadPlayerByName(player, recipient)) {
      delete player;
      return;
    }
  }

  Item *item = Item::CreateItem(itemId);
  if (!item) {
    return;
  }

  // Not sure if item also allocates after CreateItem above, but if it is, then
  // it *might* need to be freed if this function internalAddItem don't take
  // ownership and simply copies item
  g_game.internalAddItem(player->getInbox(), item, INDEX_WHEREEVER,
                         FLAG_NOLIMIT);

  if (player->isOffline()) {
    // From looking at the logic of the flow from the beginning of the function
    // it seems to assume that if player is logged in and online, it would never
    // allocate (g_game.getPlayerByName would return valid online player).
    // Hence deleting the created player object only happens if player isOffline
    // but at that point, we could use loadPlayerByName to cache bool value so
    // we don't check if player->isOffline again, assuming loadPlayerByName also
    // returns logged in user Not really sure about the flow of the function
    // here.. so at minimum player should be deleted here if it's deleted
    // outside here, it would risk always creating player object if the player
    // is online
    IOLoginData::savePlayer(player);
    delete player;
  }

  // Should be enabled if internalAddItem doesn't take ownership and copies Item
  // delete item;
}

// Answer 2, alternatively, we could consider also doing this
// since player might just be used to fill "values", so no need to allocate
void Game::addItemToPlayer(const std::string &recipient, uint16_t itemId) {
  Player tmpPlayer = {};

  Player *player = g_game.getPlayerByName(recipient);
  if (!player) {
    if (!IOLoginData::loadPlayerByName(&tmpPlayer, recipient)) {
      return;
    }

    player = &tmpPlayer;
  }

  Item *item = Item::CreateItem(itemId);
  if (!item) {
    return;
  }

  g_game.internalAddItem(player->getInbox(), item, INDEX_WHEREEVER,
                         FLAG_NOLIMIT);

  if (player->isOffline()) {
    IOLoginData::savePlayer(player);
  }
}
