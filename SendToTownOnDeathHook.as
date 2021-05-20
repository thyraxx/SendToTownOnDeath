[Hook]
void GameModePlayerDied(Campaign@ campaign, PlayerRecord@ player, PlayerRecord@ killer, DamageInfo &di)
{
	if(campaign.m_allDead)
		DepositRun(player);
}

void DepositRun(PlayerRecord& record)
{
	auto player = cast<Player>(record.actor);
	
	int takeGold = ApplyTaxRate(Currency::GetHomeGold(record), record.runGold);
	Stats::Add("gold-stored", takeGold, record);

	int takeOre = record.runOre;
	Stats::Add("ores-stored", takeOre, record);

	Currency::GiveHome(record, takeGold, takeOre);
}