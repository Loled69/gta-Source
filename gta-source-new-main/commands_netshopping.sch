//
//	commands_netshopping.sch
//
//	All script commands related to network shopping
//
USING "types.sch"

CONST_INT SHOPPING_TRANSACTION_MAX_NUMBER   15
CONST_INT SHOPPING_BASKET_MAX_NUMBER_ITEMS  70
CONST_INT NET_SHOP_INVALID_ID               2147483647


/// PURPOSE: Different states the game server session can be in. You shouldnt need to use it.
///          
ENUM GAMESERVER_STATES
	GAMESERVER_INVALID,
	GAMESERVER_PENDING_ACCESS_TOKEN,
	WAIT_FOR_START_SESSION,
	PENDING_CATALOG_VERSION,
	GAMESERVER_PENDING_CATALOG,
	GAMESERVER_CATALOG_COMPLETE,
	GAMESERVER_PENDING_SESSION_START,
	GAMESERVER_PENDING_SESSION_RESTART,
	GAMESERVER_READY,
	GAMESERVER_FAILED_ACCESS_TOKEN,
	GAMESERVER_FAILED_CATALOG,
	GAMESERVER_FAILED_SESSION_START,
	GAMESERVER_FAILED_SESSION_RESTART
ENDENUM

//Possible error codes for transactions
ENUM GAMESERVERRESULTS
	GAMESERVER_SUCCESS,
	GAMESERVER_ERROR_UNDEFINED,
	GAMESERVER_ERROR_NOT_IMPLEMENTED,
	GAMESERVER_ERROR_SYSTEM_ERROR,
	GAMESERVER_ERROR_INVALID_DATA,
	GAMESERVER_ERROR_INVALID_PRICE,
	GAMESERVER_ERROR_INSUFFICIENT_FUNDS,
	GAMESERVER_ERROR_INSUFFICIENT_INVENTORY,
	GAMESERVER_ERROR_INCORRECT_FUNDS,
	GAMESERVER_ERROR_INVALID_ITEM,
	GAMESERVER_ERROR_INVALID_PERMISSIONS,
	GAMESERVER_ERROR_INVALID_CATALOG_VERSION,
	GAMESERVER_ERROR_INVALID_TOKEN,
	GAMESERVER_ERROR_INVALID_REQUEST,
	GAMESERVER_ERROR_INVALID_ACCOUNT,
	GAMESERVER_ERROR_INVALID_NONCE,
	GAMESERVER_ERROR_EXPIRED_TOKEN,
	GAMESERVER_ERROR_CACHE_OPERATION,
	GAMESERVER_ERROR_INVALID_LIMITER_DEFINITION,
	GAMESERVER_ERROR_GAME_TRANSACTION_EXCEPTION,
	GAMESERVER_ERROR_EXCEED_LIMIT,
	GAMESERVER_ERROR_EXCEED_LIMIT_MESSAGE,
	GAMESERVER_ERROR_AUTH_FAILED,
	GAMESERVER_ERROR_STALE_DATA,
	GAMESERVER_ERROR_BAD_SIGNATURE,
	GAMESERVER_ERROR_INVALID_CONFIGURATION,
	GAMESERVER_ERROR_NET_MAINTENANCE,
	GAMESERVER_ERROR_USER_FORCE_BAIL,
	GAMESERVER_ERROR_CLIENT_FORCE_FAILED,
	GAMESERVER_ERROR_INVALID_GAME_VERSION
ENDENUM


//Possible network shot transaction status.
ENUM NET_GAMESERVER_TRANSACTION_STATUS
	TRANSACTION_STATUS_NONE, 
	TRANSACTION_STATUS_PENDING, 
	TRANSACTION_STATUS_FAILED, 
	TRANSACTION_STATUS_SUCCESSFULL,
	TRANSACTION_STATUS_CANCELED
ENDENUM
//Defines for the flags that can be set when adding items to the basket or adding services.
ENUM CATALOG_ITEM_FLAGS

	// Use only the WALLET in the transaction.
	CATALOG_ITEM_FLAG_WALLET_ONLY       = 1,

	// Use only the BANK in the transaction.
	CATALOG_ITEM_FLAG_BANK_ONLY         = 2,

	// Use the BANK then after that the WALLET in the transaction.
	CATALOG_ITEM_FLAG_BANK_THEN_WALLET  = 4,

	// Use the WALLET then after that the BANK in the transaction.
	CATALOG_ITEM_FLAG_WALLET_THEN_BANK  = 8,

	// Using Earned Virtual Cash only
	CATALOG_ITEM_FLAG_EVC_ONLY          = 16,

	// Using tokens in the transaction.
	CATALOG_ITEM_FLAG_TOKEN             = 32

ENDENUM

//Defines for actions type's.
HASH_ENUM ITEM_ACTION_TYPES
	NET_SHOP_ACTION_INVALID,

	//Action used when we transfer cash from bank account to wallet.
	NET_SHOP_ACTION_ALLOT,

	//Action used when we transfer cash from wallet to bank account.
	NET_SHOP_ACTION_RECOUP,

	//Action used when we earn cash in-game.
	NET_SHOP_ACTION_EARN,

	// Action used when we spend cash in-game.
	NET_SHOP_ACTION_SPEND,

	// Action used when we purchase GTA dolars.
	NET_SHOP_ACTION_PURCH,

	// Action used when we give cash to another player.
	NET_SHOP_ACTION_GIVE,

	// Action used when we use a certain ineventory item - not sure this will be used at all.
	NET_SHOP_ACTION_USE,

	// Action used when a character is deleted.
	NET_SHOP_ACTION_DELETE_CHAR,

	// Action used to buy an item at cost 0.
	NET_SHOP_ACTION_ACQUIRE,

	// Action used to buy a vehicle and mods at cost 0.
	NET_SHOP_ACTION_BUY_VEHICLE,

	// Action used to buy a beard, or makeup (really anything that you can only have X out of N different items in the category).
	NET_SHOP_ACTION_BUY_ITEM,

	// Action used to buy a propterty.
	NET_SHOP_ACTION_BUY_PROPERTY,

	// Action used to sell a vehicle.
	NET_SHOP_ACTION_SELL_VEHICLE,

	// Action used to buy vehicle mods only.
	NET_SHOP_ACTION_BUY_VEHICLE_MODS,

	// Create initial player appearance character.
	NET_SHOP_ACTION_CREATE_PLAYER_APPEARANCE,

	// Spend on limited service.
	NET_SHOP_ACTION_SPEND_LIMITED_SERVICE,

	// Spend on limited service.
	NET_SHOP_ACTION_EARN_LIMITED_SERVICE,

	//Buy a warehouse to store contraband
	NET_SHOP_ACTION_BUY_WAREHOUSE,

	//deducts money for the purchasing of the mission
	NET_SHOP_ACTION_BUY_CONTRABAND_MISSION,

	//used to change the quantity of contraband in a given warehouse.
	NET_SHOP_ACTION_ADD_CONTRABAND,

	//used to change the quantity of contraband in a given warehouse.
	NET_SHOP_ACTION_REMOVE_CONTRABAND,

	//resets the progress of a business (allows you to change interior and clear supply and product quantities).
	NET_SHOP_ACTION_RESET_BUSINESS_PROGRESS,

	//Updates the supply and product quantities appropriately.
	NET_SHOP_ACTION_UPDATE_BUSINESS_GOODS,

	//Updates the vehicles associated with warehouses, where applicable.
	NET_SHOP_ACTION_UPDATE_WAREHOUSE_VEHICLE,

	//Sends anticheat information back to server.
	NET_SHOP_ACTION_BONUS,

	//Action to buy casino chips
	NET_SHOP_ACTION_BUY_CASINO_CHIPS,

	//Action to sell casino chips
	NET_SHOP_ACTION_SELL_CASINO_CHIPS,

	//transaction that stores any INT value in the inventory
	NET_SHOP_ACTION_UPDATE_STORAGE_DATA,

	//Support being able to purchase the new unlock items with both GTA$ and tokens.
	NET_SHOP_ACTION_BUY_UNLOCK

ENDENUM

//Defines for transaction type's.
HASH_ENUM TRANSACTION_TYPES
	NET_SHOP_TTYPE_INVALID,
	NET_SHOP_TTYPE_BASKET,
	NET_SHOP_TTYPE_SERVICE
ENDENUM

//Defines for item categories.
HASH_ENUM SHOP_ITEM_CATEGORIES
	CATEGORY_CLOTH
	,CATEGORY_WEAPON
	,CATEGORY_WEAPON_MOD
	,CATEGORY_MART
	,CATEGORY_VEHICLE
	,CATEGORY_VEHICLE_MOD
	,CATEGORY_INVENTORY_VEHICLE_MOD
	,CATEGORY_PROPERTIE
	,CATEGORY_SERVICE
	,CATEGORY_SERVICE_WITH_THRESHOLD
	,CATEGORY_WEAPON_AMMO
	,CATEGORY_BEARD
	,CATEGORY_MKUP
	,CATEGORY_INVENTORY_ITEM
	,CATEGORY_INVENTORY_VEHICLE
	,CATEGORY_INVENTORY_PROPERTIE
	,CATEGORY_INVENTORY_BEARD
	,CATEGORY_INVENTORY_MKUP
	,CATEGORY_HAIR
	,CATEGORY_TATTOO
	,CATEGORY_INVENTORY_HAIR
	,CATEGORY_INVENTORY_EYEBROWS
	,CATEGORY_INVENTORY_CHEST_HAIR
	,CATEGORY_INVENTORY_CONTACTS
	,CATEGORY_INVENTORY_FACEPAINT
	,CATEGORY_INVENTORY_BLUSHER
	,CATEGORY_INVENTORY_LIPSTICK
	,CATEGORY_CONTACTS
	,CATEGORY_PRICE_MODIFIER
	,CATEGORY_PRICE_OVERRIDE
	,CATEGORY_SERVICE_UNLOCKED
	,CATEGORY_EYEBROWS
	,CATEGORY_CHEST_HAIR
	,CATEGORY_FACEPAINT
	,CATEGORY_BLUSHER
	,CATEGORY_LIPSTICK
	,CATEGORY_VENDING_MACHINE
	,CATEGORY_SERVICE_WITH_LIMIT
	,CATEGORY_SYSTEM
	,CATEGORY_VEHICLE_UPGRADE
	,CATEGORY_INVENTORY_PROPERTY_INTERIOR
	,CATEGORY_PROPERTY_INTERIOR
	,CATEGORY_INVENTORY_WAREHOUSE
	,CATEGORY_WAREHOUSE
	,CATEGORY_INVENTORY_CONTRABAND_MISSION
	,CATEGORY_CONTRABAND_MISSION
	,CATEGORY_CONTRABAND_QNTY
	,CATEGORY_CONTRABAND_FLAGS
	,CATEGORY_INVENTORY_WAREHOUSE_INTERIOR
	,CATEGORY_WAREHOUSE_INTERIOR
	,CATEGORY_WAREHOUSE_VEHICLE_INDEX
	,CATEGORY_INVENTORY_PRICE_PAID
	,CATEGORY_CASINO_CHIPS
	,CATEGORY_DECORATION
	,CATEGORY_DATA_STORAGE
	,CATEGORY_CASINO_CHIP_REASON
	,CATEGORY_CURRENCY_TYPE
	,CATEGORY_INVENTORY_CURRENCY
	,CATEGORY_EARN_CURRENCY
	,CATEGORY_UNLOCK
ENDENUM

//Defines for item storage types.
ENUM SHOP_ITEM_STORAGE
	NET_SHOP_ISTORAGE_INT,
	NET_SHOP_ISTORAGE_INT64,
	NET_SHOP_ISTORAGE_BITFIELD
ENDENUM

//Defines for transaction service type's.
HASH_ENUM TRANSACTION_SERVICES
	SERVICE_INVALID
	,SERVICE_SPEND_MECHANIC_WAGE
	,SERVICE_SPEND_UTILITY_BILLS
	,SERVICE_SPEND_PROSTITUTES
	,SERVICE_SPEND_STRIP_CLUB
	,SERVICE_SPEND_CINEMA
	,SERVICE_SPEND_FAIRGROUND
	,SERVICE_SPEND_LOTTERY
	,SERVICE_SPEND_TELESCOPE
	,SERVICE_SPEND_CALL_PLAYER
	,SERVICE_SPEND_VEHICLE_INSURANCE
	,SERVICE_SPEND_VEHICLE_INSURANCE_PREMIUM
	,SERVICE_SPEND_CAR_REPAIR
	,SERVICE_SPEND_PERSONAL_VEHICLE_DROPOFF
	,SERVICE_SPEND_PEGASUS_DELIVERY
	,SERVICE_SPEND_CAR_IMPOUND
	,SERVICE_SPEND_CARWASH
	,SERVICE_SPEND_HEALTHCARE
	,SERVICE_SPEND_OTHER_PLAYER_HEALTHCARE
	,SERVICE_SPEND_ARREST_BAIL
	,SERVICE_SPEND_CASH_DROP
	,SERVICE_SPEND_ROBBED_BY_MUGGER
	,SERVICE_SPEND_CASH_DROP_HOLDUP
	,SERVICE_SPEND_MATCH_ENTRY_FEE
	,SERVICE_SPEND_RACE_VEHICLE_RENTAL
	,SERVICE_SPEND_CHALLENGE_WAGER
	,SERVICE_SPEND_BETTING
	,SERVICE_SPEND_AIRSTRIKE
	,SERVICE_SPEND_AMMO_DROP
	,SERVICE_SPEND_BACKUP_GANG
	,SERVICE_SPEND_BACKUP_HELI
	,SERVICE_SPEND_BOAT_PICKUP
	,SERVICE_SPEND_BOUNTY
	,SERVICE_SPEND_BULL_SHARK
	,SERVICE_SPEND_COPS_TURN_EYE
	,SERVICE_SPEND_HELI_PICKUP
	,SERVICE_SPEND_HIRE_MERCENARY
	,SERVICE_SPEND_HIRE_MUGGER
	,SERVICE_SPEND_LOCATE_VEHICLE
	,SERVICE_SPEND_LOSE_WANTED_LEVEL
	,SERVICE_SPEND_OFF_THE_RADAR
	,SERVICE_SPEND_PASSIVE
	,SERVICE_SPEND_REQUEST_HEIST
	,SERVICE_SPEND_REQUEST_JOB
	,SERVICE_SPEND_REVEAL_PLAYERS
	,SERVICE_SPEND_TAXI
	,SERVICE_SPEND_BANK_INTEREST
	,SERVICE_SPEND_CASH_GIFT
	,SERVICE_SPEND_CASH_SHARED
	,SERVICE_SPEND_IMPROMPTU_RACE_FEE
	,SERVICE_SPEND_BOUNTY_DM
	,SERVICE_SPEND_STYLIST_FEE
	,SERVICE_SPEND_MOVE_YACHT
	,SERVICE_SPEND_BOSS_BUY_IN
	,SERVICE_SPEND_PAY_BOSS
	,SERVICE_SPEND_PAY_GOON
	,SERVICE_SPEND_WAGER
	,SERVICE_SPEND_RENAME_ORGANIZATION
	,SERVICE_SPEND_YACHT_HELI
	,SERVICE_SPEND_YACHT_BOAT
	,SERVICE_SPEND_CONTRABAND
	,SERVICE_SPEND_CONTRABAND_MISSION
    ,SERVICE_SPEND_PA_SERVICE_HELI
    ,SERVICE_SPEND_PA_SERVICE_VEHICLE
    ,SERVICE_SPEND_PA_SERVICE_SNACK
    ,SERVICE_SPEND_PA_SERVICE_DANCER
    ,SERVICE_SPEND_PA_SERVICE_IMPOUND
    ,SERVICE_SPEND_PA_SERVICE_HELI_PICKUP
    ,SERVICE_SPEND_ORDER_WAREHOUSE_VEHICLE
    ,SERVICE_SPEND_ORDER_BODYGUARD_VEHICLE
    ,SERVICE_SPEND_JUKEBOX
    ,SERVICE_SPEND_BA_VP_BOUNTY
    ,SERVICE_SPEND_BA_VP_BULLSHARK
    ,SERVICE_SPEND_BA_SARGE_AMMO
    ,SERVICE_SPEND_BA_SARGE_MOLOTOV
    ,SERVICE_SPEND_BA_ENFORCER_ARMOUR
    ,SERVICE_SPEND_BUSINESS
	,SERVICE_SPEND_VEHICLE_EXPORT_MODS
	,SERVICE_SPEND_PLAYER_APPEARANCE
	,SERVICE_SPEND_IMPORT_EXPORT_REPAIR
	,NETWORK_SPEND_HANGAR_UTILITY
	,NETWORK_SPEND_HANGAR_STAFF
	,SERVICE_SPEND_GANGOPS_CANNON
	,SERVICE_SPEND_GANGOPS_SKIP_MISSION
	,SERVICE_SPEND_GANGOPS_START_STRAND
	,SERVICE_SPEND_GANGOPS_TRIP_SKIP
	,SERVICE_SPEND_EMPLOY_ASSASSINS
	,SERVICE_SPEND_ORBITAL_MANUAL
	,SERVICE_SPEND_ORBITAL_AUTO
	,SERVICE_SPEND_GANGOPS_REPAIR_COST
	,SERVICE_SPEND_NIGHTCLUB_ENTRY_FEE
	,SERVICE_SPEND_NIGHTCLUB_BAR_DRINK
	,SERVICE_SPEND_NIGHTCLUB_DJ_REHIRE
	,SERVICE_SPEND_ARENA_JOIN_SPECTATOR
	,SERVICE_SPEND_ARENA_SPECTATOR_BOX
	,SERVICE_SPEND_SPIN_THE_WHEEL_PAYMENT
	,SERVICE_SPEND_MAKE_IT_RAIN
	,SERVICE_SPEND_ARENA_PREMIUM_EVENT_ENTRY
	,SERVICE_SPEND_CASINO_MEMBERSHIP
	,SERVICE_SPEND_CASINO_GENERIC
	,SERVICE_SPEND_ARCADE_GAME
	,SERVICE_SPEND_ARCADE_GENERIC
	,SERVICE_SPEND_CASINO_HEIST_SKIP_MISSION
	,SERVICE_SPEND_CASINO_HEIST_SETUP_HEIST
	,SERVICE_SPEND_CASINO_HEIST_CASINO_MODEL
	,SERVICE_SPEND_CASINO_HEIST_VAULT_DOOR
	,SERVICE_SPEND_CASINO_HEIST_DOOR_SECURITY
	,SERVICE_SPEND_ISLAND_HEIST_SUPPORT_AIRSTRIKE
	,SERVICE_SPEND_ISLAND_HEIST_SUPPORT_HEAVY_WEAPON
	,SERVICE_SPEND_ISLAND_HEIST_SUPPORT_SNIPER
	,SERVICE_SPEND_ISLAND_HEIST_SUPPORT_AIR_SUPPORT
	,SERVICE_SPEND_ISLAND_HEIST_SUPPORT_DRONE
	,SERVICE_SPEND_ISLAND_HEIST_SUPPORT_WEAPON_STASH
	,SERVICE_SPEND_ISLAND_HEIST_SUPPRESSORS
	,SERVICE_SPEND_ISLAND_HEIST_REPLAY
	,SERVICE_SPEND_BEACH_PARTY_GENERIC
	,SERVICE_SPEND_CASINO_CLUB_GENERIC
	,SERVICE_SPEND_SUBMARINE_UTILITY_FEE
	,SERVICE_SPEND_SUBMARINE_BOAT
	,SERVICE_SPEND_SUBMARINE_RELOCATION
	,SERVICE_SPEND_INTERACTION_MENU_ABILITY
	,SERVICE_SPEND_BUSINESS_EXPENSES
	,SERVICE_SPEND_REQUEST_SUPPLY
	,SERVICE_SPEND_REQUEST_SOURCE_MOTORCYCLE
	,SERVICE_SPEND_REQUEST_OUT_OF_SIGHT
	,SERVICE_SPEND_FIXER_HQ_CONCIERGE
	,SERVICE_SPEND_REQUEST_COMPANY_SUV
	,SERVICE_SPEND_SOURCE_CARGO
	,SERVICE_SPEND_AGENT_14_VEHICLE_REQUEST
	,SERVICE_SPEND_TONY_LIMO
	,SERVICE_SPEND_JUGALLO_BOSS_VEHICLE_REQUEST
	,SERVICE_EARN_PICKUP
	,SERVICE_EARN_CASHING_OUT
	,SERVICE_EARN_INITIAL_CASH
	,SERVICE_EARN_JOBS
	,SERVICE_EARN_BETTING
	,SERVICE_EARN_LOTTERY
	,SERVICE_EARN_CHALLENGE_WIN
	,SERVICE_EARN_PROPERTY_SALES
	,SERVICE_EARN_VEHICLE_SALES
	,SERVICE_EARN_LESTER_TARGET_KILL
	,SERVICE_EARN_BOUNTY_COLLECTED
	,SERVICE_EARN_CRATE_DROP
	,SERVICE_EARN_HOLDUPS
	,SERVICE_EARN_IMPORT_EXPORT
	,SERVICE_EARN_ARMORED_TRUCKS
	,SERVICE_EARN_JOBSHARE_CASH
	,SERVICE_EARN_NOT_BADSPORT
	,SERVICE_EARN_BANK_INTEREST
	,SERVICE_EARN_ROCKSTAR
	,SERVICE_EARN_DEBUG
	,SERVICE_EARN_CNCW
	,SERVICE_EARN_CNCB
	,SERVICE_EARN_JOB_BONUS
	,SERVICE_EARN_JOB_BONUS_CRIMINAL_MASTERMIND
	,SERVICE_EARN_JOB_BONUS_HEIST_AWARD
	,SERVICE_EARN_JOB_BONUS_FIRST_TIME_BONUS
	,SERVICE_EARN_BEND_JOB
	,SERVICE_EARN_PREMIUM_JOB
	,SERVICE_EARN_PERSONAL_VEHICLE
	,SERVICE_EARN_DAILY_OBJECTIVES
	,SERVICE_EARN_AMBIENT_JOB_PLANE_TAKEDOWN 
	,SERVICE_EARN_AMBIENT_JOB_DISTRACT_COPS 
	,SERVICE_EARN_AMBIENT_JOB_DESTROY_VEH 
	,SERVICE_EARN_REFUND_BACKUP_VAGOS 
	,SERVICE_EARN_REFUND_BACKUP_LOST 
	,SERVICE_EARN_REFUND_BACKUP_FAMILIES
	,SERVICE_EARN_REFUND_HIRE_MUGGER 
	,SERVICE_EARN_REFUND_HIRE_MERCENARY 
	,SERVICE_EARN_REFUND_BUY_CARDROPOFF 
	,SERVICE_EARN_REFUND_HELI_PICKUP
	,SERVICE_EARN_REFUND_BOAT_PICKUP 
	,SERVICE_EARN_REFUND_CLEAR_WANTED 
	,SERVICE_EARN_REFUND_HEAD_2_HEAD 
	,SERVICE_EARN_REFUND_CHALLENGE 
	,SERVICE_EARN_REFUND_SHARE_LAST_JOB 
	,SERVICE_EARN_REFUND_LOTTERY
	,SERVICE_EARN_GANGATTACK_PICKUP
	,SERVICE_EARN_AMBIENT_JOB_HOT_TARGET_DELIVER
	,SERVICE_EARN_AMBIENT_JOB_HOT_TARGET_KILL
	,SERVICE_EARN_AMBIENT_JOB_PLANE_DROP
	,SERVICE_EARN_AMBIENT_JOB_URBAN_WARFARE
	,SERVICE_EARN_AMBIENT_JOB_CHECKPOINT_COLLECTION
	,SERVICE_EARN_AMBIENT_JOB_TIME_TRIAL
	,SERVICE_EARN_AMBIENT_JOB_CHALLENGES
	,SERVICE_EARN_AMBIENT_JOB_HELI_HOT_TARGET
	,SERVICE_EARN_AMBIENT_JOB_DEAD_DROP
	,SERVICE_EARN_AMBIENT_JOB_PENNED_IN
	,SERVICE_EARN_AMBIENT_JOB_MULTI_TARGET
	,SERVICE_EARN_AMBIENT_JOB_PASS_PARCEL
	,SERVICE_EARN_AMBIENT_JOB_BLAST
	,SERVICE_EARN_AMBIENT_JOB_HOT_PROPERTY
	,SERVICE_EARN_AMBIENT_JOB_KING
	,SERVICE_EARN_AMBIENT_JOB_INFECT
	,SERVICE_EARN_AMBIENT_JOB_MYSTERY_TEXT
	,SERVICE_EARN_AMBIENT_JOB_BEAST
	,SERVICE_EARN_BOSS
	,SERVICE_EARN_GOON
	,SERVICE_EARN_BOSS_AGENCY
	,SERVICE_EARN_WAGE_PAYMENT
	,SERVICE_EARN_WAGE_PAYMENT_BONUS
	,SERVICE_EARN_FROM_CONTRABAND
	,SERVICE_EARN_FROM_WAREHOUSE
	,SERVICE_EARN_FROM_DESTROYING_CONTRABAND
	,SERVICE_EARN_FROM_BUSINESS_PRODUCT
	,SERVICE_EARN_REFUNDAPPEARANCE
	,SERVICE_EARN_FROM_VEHICLE_EXPORT
	,SERVICE_EARN_RDR_BONUS_ALL_SLOTS
	,SERVICE_EARN_SMUGGLER_AGENCY
	,SERVICE_EARN_REFUNDAMMODROP
	,SERVICE_EARN_SALVAGE_CHECKPOINT_COLLECTION
	,SERVICE_EARN_AMBIENT_MUGGING
	,SERVICE_EARN_AMBIENT_PICKUP
	,SERVICE_EARN_DEATHMATCH_BOUNTY
	,SERVICE_EARN_REFUND_ORBITAL_MANUAL
	,SERVICE_EARN_REFUND_ORBITAL_AUTO
	,SERVICE_EARN_GANGOPS_WAGES
	,SERVICE_EARN_GANGOPS_WAGES_BONUS
	,SERVICE_EARN_DAR_CHALLENGE
	,SERVICE_EARN_GANGOPS_PREP_PARTICIPATION
	,SERVICE_EARN_GANGOPS_SETUP
	,SERVICE_EARN_GANGOPS_SETUP_FAIL
	,SERVICE_EARN_GANGOPS_FINALE
	,SERVICE_EARN_GANGOPS_AWARD_MASTERMIND_2
	,SERVICE_EARN_GANGOPS_AWARD_MASTERMIND_3
	,SERVICE_EARN_GANGOPS_AWARD_MASTERMIND_4
	,SERVICE_EARN_GANGOPS_AWARD_LOYALTY_AWARD_2
	,SERVICE_EARN_GANGOPS_AWARD_LOYALTY_AWARD_3
	,SERVICE_EARN_GANGOPS_AWARD_LOYALTY_AWARD_4
	,SERVICE_EARN_GANGOPS_AWARD_FIRST_TIME_XM_BASE
	,SERVICE_EARN_GANGOPS_AWARD_FIRST_TIME_XM_SUBMARINE
	,SERVICE_EARN_GANGOPS_AWARD_FIRST_TIME_XM_SILO
	,SERVICE_EARN_GANGOPS_AWARD_SUPPORTING
	,SERVICE_EARN_GANGOPS_AWARD_ORDER
	,SERVICE_EARN_GANGOPS_ELITE_XM_BASE
	,SERVICE_EARN_GANGOPS_ELITE_XM_SUBMARINE
	,SERVICE_EARN_GANGOPS_ELITE_XM_SILO 
	,SERVICE_EARN_GANGOPS_RIVAL_DELIVERY
	,SERVICE_EARN_DOOMSDAY_FINALE_BONUS
	,SERVICE_EARN_BOUNTY_HUNTER_REWARD
	,SERVICE_EARN_FROM_BUSINESS_BATTLE
	,SERVICE_EARN_FROM_CLUB_MANAGEMENT_PARTICIPATION
	,SERVICE_EARN_FROM_FMBB_PHONECALL_MISSION
	,SERVICE_EARN_FROM_BUSINESS_HUB_SELL
	,SERVICE_EARN_FROM_FMBB_BOSS_WORK
	,SERVICE_EARN_FMBB_WAGE_BONUS
	,SERVICE_EARN_NIGHTCLUB_DANCING_AWARD
	,SERVICE_EARN_RDR_BONUS_ALL_SLOTS_1
	,SERVICE_EARN_BB_EVENT_BONUS
	,SERVICE_EARN_ARENA_SKILL_LVL_AWARD
	,SERVICE_EARN_ASSASSINATE_TARGET_KILLED
	,SERVICE_EARN_SPIN_THE_WHEEL_CASH
	,SERVICE_EARN_ARENA_CAREER_TIER_PROGRESSION_1
	,SERVICE_EARN_ARENA_CAREER_TIER_PROGRESSION_2
	,SERVICE_EARN_ARENA_CAREER_TIER_PROGRESSION_3
	,SERVICE_EARN_ARENA_CAREER_TIER_PROGRESSION_4
	,SERVICE_EARN_ARENA_WAR
	,SERVICE_EARN_REFUND_ARENA_SPEC_BOX_ENTRY
	,SERVICE_EARN_AMBIENT_JOB_RC_TIME_TRIAL
	,SERVICE_EARN_DAILY_OBJECTIVE_EVENT
	,SERVICE_EARN_COLLECTABLES_ACTION_FIGURES
	,SERVICE_EARN_CASINO_MISSION_REWARD
	,SERVICE_EARN_CASINO_STORY_MISSION_REWARD
	,SERVICE_EARN_CASINO_AWARD_MISSION_ONE_FIRST_TIME
	,SERVICE_EARN_CASINO_AWARD_MISSION_TWO_FIRST_TIME
	,SERVICE_EARN_CASINO_AWARD_MISSION_THREE_FIRST_TIME
	,SERVICE_EARN_CASINO_AWARD_MISSION_FOUR_FIRST_TIME
	,SERVICE_EARN_CASINO_AWARD_MISSION_FIVE_FIRST_TIME
	,SERVICE_EARN_CASINO_AWARD_MISSION_SIX_FIRST_TIME
	,SERVICE_EARN_CASINO_AWARD_STRAIGHT_FLUSH
	,SERVICE_EARN_CASINO_AWARD_TOP_PAIR
	,SERVICE_EARN_CASINO_AWARD_FULL_HOUSE
	,SERVICE_EARN_CASINO_AWARD_LUCKY_LUCKY
	,SERVICE_EARN_CASINO_AWARD_HIGH_ROLLER_BRONZE
	,SERVICE_EARN_CASINO_AWARD_HIGH_ROLLER_SILVER
	,SERVICE_EARN_CASINO_AWARD_HIGH_ROLLER_GOLD
	,SERVICE_EARN_CASINO_AWARD_HIGH_ROLLER_PLATINUM
	,SERVICE_EARN_CASINO_HEIST_SETUP_MISSION
	,SERVICE_EARN_CASINO_HEIST_PREP_MISSION
	,SERVICE_EARN_CASINO_HEIST_FINALE
	,SERVICE_EARN_CASINO_HEIST_AWARD_SMASH_N_GRAB
	,SERVICE_EARN_CASINO_HEIST_AWARD_IN_PLAIN_SIGHT
	,SERVICE_EARN_CASINO_HEIST_AWARD_UNDETECTED
	,SERVICE_EARN_CASINO_HEIST_AWARD_ALL_ROUNDER
	,SERVICE_EARN_CASINO_HEIST_AWARD_ELITE_THIEF
	,SERVICE_EARN_CASINO_HEIST_AWARD_PROFESSIONAL
	,SERVICE_EARN_CASINO_HEIST_ELITE_STEALTH
	,SERVICE_EARN_CASINO_HEIST_ELITE_SUBTERFUGE
	,SERVICE_EARN_CASINO_HEIST_ELITE_DIRECT
	,SERVICE_EARN_COLLECTABLE_ITEM
	,SERVICE_EARN_COLLECTABLE_COMPLETED_COLLECTION
	,SERVICE_EARN_COLLECTABLES_SIGNAL_JAMMERS
	,SERVICE_EARN_COLLECTABLES_SIGNAL_JAMMERS_COMPLETE
	,SERVICE_EARN_ISLAND_HEIST_FINALE
	,SERVICE_EARN_ISLAND_HEIST_ELITE_CHALLENGE
	,SERVICE_EARN_ISLAND_HEIST_AWARD_PROFESSIONAL
	,SERVICE_EARN_ISLAND_HEIST_AWARD_ELITE_THIEF
	,SERVICE_EARN_ISLAND_HEIST_AWARD_THE_ISLAND_HEIST
	,SERVICE_EARN_ISLAND_HEIST_AWARD_GOING_ALONE
	,SERVICE_EARN_ISLAND_HEIST_AWARD_TEAM_WORK
	,SERVICE_EARN_ISLAND_HEIST_AWARD_CAT_BURGLAR
	,SERVICE_EARN_ISLAND_HEIST_AWARD_PRO_THIEF
	,SERVICE_EARN_ISLAND_HEIST_AWARD_MIXING_IT_UP
	,SERVICE_EARN_ISLAND_HEIST_PREP
	,SERVICE_EARN_ISLAND_HEIST_DJ_MISSION
	,SERVICE_EARN_TUNER_ROBBERY_PREP
	,SERVICE_EARN_TUNER_ROBBERY_FINALE	
	,SERVICE_EARN_TUNER_CAR_CLUB_MEMBERSHIP
	,SERVICE_EARN_TUNER_DAILY_VEHICLE
	,SERVICE_EARN_TUNER_DAILY_VEHICLE_BONUS	
	,SERVICE_EARN_TUNER_AWARD_UNION_DEPOSITORY
	,SERVICE_EARN_TUNER_AWARD_MILITARY_CONVOY
	,SERVICE_EARN_TUNER_AWARD_FLEECA_BANK
	,SERVICE_EARN_TUNER_AWARD_FREIGHT_TRAIN
	,SERVICE_EARN_TUNER_AWARD_BOLINGBROKE_ASS
	,SERVICE_EARN_TUNER_AWARD_IAA_RAID
	,SERVICE_EARN_TUNER_AWARD_METH_JOB
	,SERVICE_EARN_TUNER_AWARD_BUNKER_RAID
	,SERVICE_EARN_AMBIENT_JOB_HSW_TIME_TRIAL
	,SERVICE_EARN_AUTO_SHOP_DELIVERY_AWARD	
	,SERVICE_EARN_AGENCY_SECURITY_CONTRACT
	,SERVICE_EARN_AGENCY_PAYPHONE_HIT
	,SERVICE_EARN_AGENCY_STORY_PREP
	,SERVICE_EARN_AGENCY_STORY_FINALE
	,SERVICE_EARN_FIXER_RIVAL_DELIVERY
	,SERVICE_EARN_FIXER_AWARD_SEC_CON
	,SERVICE_EARN_FIXER_AWARD_PHONE_HIT
	,SERVICE_EARN_FIXER_AWARD_AGENCY_STORY
	,SERVICE_EARN_FIXER_AWARD_SHORT_TRIP
	,SERVICE_EARN_MUSIC_STUDIO_SHORT_TRIP
	,SERVICE_EARN_NCLUB_TROUBLEMAKER
	,SERVICE_EARN_CLUBHOUSE_DUFFLE_BAG	
	,SERVICE_EARN_SIGHTSEEING_REWARD
	,SERVICE_EARN_AMBIENT_JOB_CLUBHOUSE_CONTRACT
	,SERVICE_EARN_AMBIENT_JOB_UNDERWATER_CARGO
	,SERVICE_EARN_AMBIENT_JOB_CRIME_SCENE
	,SERVICE_EARN_AMBIENT_JOB_METAL_DETECTOR
	,SERVICE_EARN_AMBIENT_JOB_SMUGGLER_PLANE
	,SERVICE_EARN_AMBIENT_JOB_SMUGGLER_TRAIL
	,SERVICE_EARN_AMBIENT_JOB_GOLDEN_GUN
	,SERVICE_EARN_AMBIENT_JOB_AMMUNATION_DELIVERY
	,SERVICE_EARN_AMBIENT_JOB_SOURCE_RESEARCH
	,SERVICE_EARN_YOHAN_SOURCE_GOODS
//	#IF FEATURE_COPS_N_CROOKS
//	,SERVICE_EARN_CNC_EOM
//	#ENDIF
ENDENUM

///PURPOSE
///  Network Event sent when the scAdmin makes changes to player balance/inventory
///   this event can be triggered in sp/mp.
///
CONST_INT MAX_NUM_ITEMS 20
STRUCT SCADMIN_UPDATE_EVENT
	INT m_fullRefreshRequested
	INT m_updatePlayerBalance
	INT m_awardTypeHash
	INT m_awardAmount
	INT m_items[MAX_NUM_ITEMS]
ENDSTRUCT

/////////////////////////////////////////////////////////////////////
////////////////////////// INVENTORY ITEMS //////////////////////////
/////////////////////////////////////////////////////////////////////

#IF IS_DEBUG_BUILD

//PURPOSE: This structure can be used to construct our catalog
STRUCT ScriptCatalogItem

	//Unique Key used to identify a catalog item.
	TEXT_LABEL_63  m_key

	//Text Label used for the item.
	TEXT_LABEL_15  m_textTag
	
	//Name of the catalog item
	TEXT_LABEL_63  m_name

	//Category for the item.
	SHOP_ITEM_CATEGORIES  m_category

	//Price value of the Item.
	INT  m_price

	//Identifier of the stat that this item uses.
	INT  m_stathash

	//Identifier of the stat that this item uses.
	SHOP_ITEM_STORAGE  m_storagetype

	//Number of bits that the stat is shifted.
	INT  m_bitshift

	//Number of bits that the stat uses.
	INT  m_bitsize

	//Value for the stat enum in packed stats used for vehicle mods stat key calculations.
	INT  m_statenumvalue

	//Value for the catalog only entries that represent prices for inventory items.
	INT  m_statvalue

ENDSTRUCT

/// PURPOSE: Add items to our catalog
/// INFO: 
NATIVE PROC NET_GAMESERVER_ADD_ITEM_TO_CATALOG(ScriptCatalogItem& item) = "0xeae106f5d3d0bc4c"
NATIVE FUNC BOOL NET_GAMESERVER_REMOVE_CATALOG_ITEM(TEXT_LABEL_63& catalogItemKey) = "0x4981147c2112fc49"

/// PURPOSE: Change item price.
/// INFO: 
NATIVE FUNC BOOL NET_GAMESERVER_SET_CATALOG_ITEM_PRICE(TEXT_LABEL_63& itemkey, INT itemPrice) = "0xc09c98b726ee9579"

/// PURPOSE: Change item text label.
/// INFO: 
NATIVE FUNC BOOL NETWORK_SHOP_SET_CATALOG_ITEM_TEXT_LABEL(TEXT_LABEL_63& itemkey, TEXT_LABEL_63& textLabel) = "0x727c37960f5938ad"

/// PURPOSE: Links 2 items in the catalog - if itemkeyA/itemkeyB is bought it will open the other item.
/// INFO: By default Links A->B and B->A ( circular )
NATIVE FUNC BOOL NET_GAMESERVER_LINK_CATALOG_ITEMS(TEXT_LABEL_63& itemkeyA, TEXT_LABEL_63& itemkeyB, BOOL createCircularLink = TRUE) = "0x72fe3b99a6581589"
NATIVE FUNC BOOL NET_GAMESERVER_ARE_CATALOG_ITEMS_LINKED(TEXT_LABEL_63& itemkeyA, TEXT_LABEL_63& itemkeyB, BOOL checkForCircularLink = TRUE) = "0x1e62f4e93e204976"
NATIVE FUNC BOOL NET_GAMESERVER_REMOVE_LINKED_CATALOG_ITEMS(TEXT_LABEL_63& itemkeyA, TEXT_LABEL_63& itemkeyB, BOOL removeCircularLink = TRUE) = "0x927fc8dbe80ddc06"

/// PURPOSE: Links 2 items in the catalog - if itemkeyA is sold it will also delete itemkeyB from the inventory
/// INFO: 
NATIVE FUNC BOOL NET_GAMESERVER_LINK_CATALOG_ITEMS_FOR_SELLING(TEXT_LABEL_63& itemkeyA, TEXT_LABEL_63& itemkeyB) = "0xcfa402b56b643034"
NATIVE FUNC BOOL NET_GAMESERVER_ARE_CATALOG_ITEMS_LINKED_FOR_SELLING(TEXT_LABEL_63& itemkeyA, TEXT_LABEL_63& itemkeyB) = "0xac492242e9d75a50"
NATIVE FUNC BOOL NET_GAMESERVER_REMOVE_LINK_CATALOG_ITEMS_FOR_SELLING(TEXT_LABEL_63& itemkeyA, TEXT_LABEL_63& itemkeyB) = "0x6b8f793f06355be7"

/// PURPOSE: Returns the current catalog version of the game
/// INFO: 
NATIVE FUNC INT NET_GAMESERVER_GET_CATALOG_VERSION() = "0x674cb733ad247516"

#ENDIF //IS_DEBUG_BUILD

/// PURPOSE: Check if a catalog item exists.
/// INFO: 
NATIVE FUNC BOOL NET_GAMESERVER_CATALOG_ITEM_IS_VALID( TEXT_LABEL_63&  itemkey ) = "0x5b1b2a8fe51fdb2d"
NATIVE FUNC BOOL NET_GAMESERVER_CATALOG_ITEM_KEY_IS_VALID( INT  itemkey ) = "0x30057de4703c0da0"


/////////////////////////////////////////////////////////////////////
////////////////////////// CATALOG ITEMS //////////////////////////
/////////////////////////////////////////////////////////////////////

/// INFO:  Make sure  catalog is valid before even downloading the savegame using 
///        NET_GAMESERVER_CATALOG_IS_VALID. That can possibly be done at the same time the savegame 
///        is being downloaded but probably is better to just do it before.
///
///        Usually you wont need to do anything since code tries to download the catalog for you. So 
///        use commands to make sure it has been done and if NET_GAMESERVER_CATALOG_IS_VALID is FALSE and 
///        NET_GAMESERVER_RETRIEVE_CATALOG_STATUS is false as well then try to use the NET_GAMESERVER_RETRIEVE_CATALOG.

/// PURPOSE: Check if the catalog is valid and ready to be used.
NATIVE FUNC BOOL NET_GAMESERVER_CATALOG_IS_VALID(  ) = "0xa10787b951345252"

/// PURPOSE: Check if the catalog is current, otherwise script will need to request the catalog again.
NATIVE FUNC BOOL NET_GAMESERVER_IS_CATALOG_CURRENT(  ) = "0xd6056e80737899a4"

/// PURPOSE: Retrieve an item price. Item can be from the inventory 
///          or a service.
NATIVE FUNC INT NET_GAMESERVER_GET_PRICE( INT itemId, SHOP_ITEM_CATEGORIES category, INT quantity ) = "0xbc8c74780a771297"
NATIVE FUNC INT NET_GAMESERVER_GET_CATEGORY( INT itemId ) = "0x1ea222bdb50cd0dc"

/// PURPOSE:
///    Get the crc from the catalog. 
NATIVE FUNC INT NET_GAMESERVER_GET_CATALOG_CLOUD_CRC() = "0x5c1d76a1af94a070"

/// PURPOSE:
///    Requests the server catalog file. 
NATIVE FUNC BOOL NET_GAMESERVER_REFRESH_SERVER_CATALOG() = "0xbf1625e3bc032624"

/// PURPOSE: Retrieve status from the operation started in NET_GAMESERVER_REFRESH_SERVER_CATALOG. Returns TRUE is status is successfull.
///          Returns FALSE when the status is PENDING/FAILED.
NATIVE FUNC BOOL NET_GAMESERVER_RETRIEVE_CATALOG_REFRESH_STATUS( NET_GAMESERVER_TRANSACTION_STATUS& currentStatus ) = "0x4f62f2c5dfe165d1"

//PURPOSE: True when we're waiting for a refresh from the server.  This can happen when the game token times out.  The server will
//  send a GAMESERVER_ERROR_INVALID_NONCE or GAMESERVER_ERROR_EXPIRED_TOKEN
NATIVE FUNC BOOL NET_GAMESERVER_GET_SESSION_STATE_AND_STATUS(INT& currentState, INT& refreshSessionRequested) = "0x5d66da471cacd32b"

/////////////////////////////////////////////////////////////////////
////////////////////////// SHOP SESSION /////////////////////////////
/////////////////////////////////////////////////////////////////////

/// PURPOSE: Does slot independant shop session initializition (downloads the server catalog among other things).
NATIVE FUNC BOOL NET_GAMESERVER_INIT_SESSION( ) = "0x7f3fea7d9cf0dc6e"

/// PURPOSE: After NET_GAMESERVER_INIT_SESSION use this to fetch the status - Returns TRUE when the operation is succssfull.
NATIVE FUNC BOOL NET_GAMESERVER_RETRIEVE_INIT_SESSION_STATUS( NET_GAMESERVER_TRANSACTION_STATUS& currentStatus ) = "0x235f4dc72bbcc553"

/// PURPOSE: Check if the game is waiting for script to call NET_GAMESERVER_START_SESSION and set a slot to be fetched (retrieves the inventory and player balance)
NATIVE FUNC BOOL NET_GAMESERVER_START_SESSION_PENDING( ) = "0xfcac2ba43eebfd67"

/// PURPOSE: Actually starts the shop session for a given slot (retrieves the inventory and player balance)
NATIVE FUNC BOOL NET_GAMESERVER_START_SESSION( INT slot ) = "0xd18d5a2e89ffbbdd"

/// PURPOSE: After NET_GAMESERVER_START_SESSION use this to fetch the status - Returns TRUE when the operation is succssfull.
NATIVE FUNC BOOL NET_GAMESERVER_RETRIEVE_START_SESSION_STATUS( NET_GAMESERVER_TRANSACTION_STATUS& currentStatus ) = "0xae7d86f9ae8e7023"

/// PURPOSE: Gets the error code if the session failed (if either INIT or START failed).
NATIVE FUNC BOOL NET_GAMESERVER_RETRIEVE_SESSION_ERROR_CODE( INT& errorCode ) = "0xf5cd50011aebed08"

/// PURPOSE: Check if Shop session is valid and ready to use (the simpler version of NET_GAMESERVER_RETRIEVE_START_SESSION_STATUS).
NATIVE FUNC BOOL NET_GAMESERVER_IS_SESSION_VALID( INT slot ) = "0xd487b8e9c523defd"

/// PURPOSE: Clear NET_GAMESERVER_IS_SESSION_VALID from download status.
NATIVE FUNC BOOL NET_GAMESERVER_CLEAR_SESSION( INT slot ) = "0xd96b781b65d4d071"

/// PURPOSE: Apply the data received from the server (ala NET_GAMESERVER_START_SESSION)
///		Note: Be sure check the NET_GAMESERVER_RETRIEVE_START_SESSION_STATUS
NATIVE FUNC BOOL NET_GAMESERVER_SESSION_APPLY_RECEIVED_DATA( INT slot) = "0xcbcd6607d498169c"
NATIVE FUNC BOOL NET_GAMESERVER_START_SESSION_APPLY_DATA_PENDING( ) = "0xc87fbaa0b0e40d50"

/// PURPOSE: Returns TRUE if the session is being refreshed so no transactions can be done.
NATIVE FUNC BOOL NET_GAMESERVER_IS_SESSION_REFRESH_PENDING( ) = "0xba5b5030b7954daa"

/// PURPOSE: Start a session restart must be called when we are in mp and have 
///           received a presence message and is safe to retrieve the inventory and/or player balance)
NATIVE FUNC BOOL NET_GAMESERVER_START_SESSION_RESTART( BOOL inventory, BOOL playerbalance ) = "0xd05c5303ee30788b"

/// PURPOSE: After NET_GAMESERVER_START_SESSION_RESTART use this to fetch the status - Returns TRUE when the operation is succssfull.
NATIVE FUNC BOOL NET_GAMESERVER_START_SESSION_RESTART_STATUS( NET_GAMESERVER_TRANSACTION_STATUS& currentStatus ) = "0x6ed91b81a6269d6f"

/// PURPOSE: Gets the error code if the session failed (if RESTART failed).
NATIVE FUNC BOOL NET_GAMESERVER_START_SESSION_RESTART_ERROR_CODE( INT& errorCode ) = "0xb7b8a0edefdb1cdf"

/// PURPOSE: Returns TRUE if a transaction is in Progress.
NATIVE FUNC BOOL NET_GAMESERVER_TRANSACTION_IN_PROGRESS( ) = "0xb76e8f198fb54340"

/// PURPOSE:  Returns true when we should be using the transactions server
NATIVE FUNC BOOL NET_GAMESERVER_USE_SERVER_TRANSACTIONS( ) = "0xa50ced7fb6e38751"

/// PURPOSE:  Returns true when a slot is valid. Must be checked After StartSession is successfull.
NATIVE FUNC BOOL NET_GAMESERVER_GET_SLOT_IS_VALID(INT slot) = "0x4c7642b2101d7980"

/////////////////////////////////////////////////////////////////////
////////////////////////// SHOPPING BASKET //////////////////////////
/////////////////////////////////////////////////////////////////////

//PURPOSE
//  specific data for buyng a item and adding to the basket.
STRUCT srcBasketItem

	//Catalog item key - this will have info about the item price.
	INT m_catalogKey

	//key - this will have info about the item in inventory, some items need 2 catalog entries one for the price and one for the inventory.
	INT m_extraInventoryKey

	//Item cost - this can be the value specified in the catalog 
	//   or what the client think it is.
	INT m_price

	//New stat value that will be set in the inventory.
	INT m_statvalue

ENDSTRUCT

/// PURPOSE: Create a basket for shopping. If doesnt exist already
/// INFO: 
NATIVE FUNC BOOL NET_GAMESERVER_BASKET_START( INT& transactionId, SHOP_ITEM_CATEGORIES category, ITEM_ACTION_TYPES action, CATALOG_ITEM_FLAGS flags = CATALOG_ITEM_FLAG_WALLET_ONLY) = "0x76503dcd0bb2d833"

/// PURPOSE: End Basket and let code know script doesnt need it anymore. This should only be 
///           when we are done with shooping and after the transaction has ended. We need to deal with error cases.
/// INFO: 
NATIVE FUNC BOOL NET_GAMESERVER_BASKET_END( ) = "0x349e25ea131c0e2a"

/// PURPOSE: Returns TRUE if there is ab Active basket.
/// INFO: 
NATIVE FUNC BOOL NET_GAMESERVER_BASKET_IS_ACTIVE( ) = "0x3f5b892c35f3ff91"

/// PURPOSE: Add an item to the basket
/// INFO: 
NATIVE FUNC BOOL NET_GAMESERVER_BASKET_ADD_ITEM( srcBasketItem& basketItem, INT quantity ) = "0x598e220bd27f56ca"

/// PURPOSE: Remove an item from the basket
/// INFO: 
NATIVE FUNC BOOL NET_GAMESERVER_BASKET_REMOVE_ITEM( INT itemId ) = "0x1fefd84932535f01"

/// PURPOSE: check if a item already exists in the basket
/// INFO: 
NATIVE FUNC BOOL NET_GAMESERVER_BASKET_ITEM_EXISTS( INT id ) = "0xccbf14d35011465d"

/// PURPOSE: Clear all items from the basket.
/// INFO: 
NATIVE FUNC BOOL NET_GAMESERVER_BASKET_CLEAR_ALL_ITEMS( ) = "0x0c49ee0c4d33a89e"

/// PURPOSE: Check if the basket is empty.
/// INFO: 
NATIVE FUNC BOOL NET_GAMESERVER_BASKET_IS_EMPTY( ) = "0xdb42c3058f7a5848"

/// PURPOSE: Check if the basket is full.
/// INFO: 
NATIVE FUNC BOOL NET_GAMESERVER_BASKET_IS_FULL( ) = "0x03a58b305ffa997e"

/// PURPOSE: Retrieve the number of items currently in the basket.
/// INFO: 
NATIVE FUNC INT NET_GAMESERVER_BASKET_GET_NUMBER_OF_ITEMS( ) = "0x887808f47bc32256"

//NOTE: This struct matches a code struct.
STRUCT SHOP_BASKET_SERVER_DATA_INFO
	BOOL bCashUpdateReceived	//Will be true if a cash update was received from the server.
	
	//Local vs. Server (how much did the server values change the local value)
	INT bankCashDifference 		
	INT walletCashDifference

	BOOL inventoryReceived		//True if inventory data was received
	INT iNumItems				//Number of invenotry items updated.
	
ENDSTRUCT

/// PURPOSE: Apply player balance and inventory item set data to stats.
/// INFO: 
NATIVE FUNC BOOL NET_GAMESERVER_BASKET_APPLY_SERVER_DATA( INT transactionId, SHOP_BASKET_SERVER_DATA_INFO& info ) = "0xa51a2c9006cd8004"


///////////////////////////////////////////////////////////////////////
////////////////////////// SHOPPING CHECKOUT //////////////////////////
///////////////////////////////////////////////////////////////////////

/// PURPOSE: Start the checkout of all items pending to be paid for.
/// INFO: This command should be used for the BASKET and SERVICES.
NATIVE FUNC BOOL NET_GAMESERVER_CHECKOUT_START( INT transactionId ) = "0xe894c3f21e583743"

/// PURPOSE: Returns TRUE when a checkout is in progress.
/// INFO: 
NATIVE FUNC BOOL NET_GAMESERVER_CHECKOUT_PENDING( INT transactionId ) = "0x46db1d48f2d7c08e"

/// PURPOSE: Returns TRUE when a checkout has completed successfully.
/// INFO: 
NATIVE FUNC BOOL NET_GAMESERVER_CHECKOUT_SUCCESSFUL( INT transactionId ) = "0x68d94c40347d7aec"


//////////////////////////////////////////////////////////////
////////////////////////// SERVICES //////////////////////////
//////////////////////////////////////////////////////////////

/// PURPOSE: Returns TRUE if we managed to start paying a certain service.
/// INFO: see TRANSACTION_SERVICES for all service types. Returns the unique 
///         transaction identifier in transactionId. Please use that id for other commands.
NATIVE FUNC BOOL NET_GAMESERVER_BEGIN_SERVICE( INT& transactionId, SHOP_ITEM_CATEGORIES category, TRANSACTION_SERVICES service, ITEM_ACTION_TYPES actionType, INT cost, CATALOG_ITEM_FLAGS flags = CATALOG_ITEM_FLAG_WALLET_ONLY ) = "0x651232f0fbbd6c7f"

/// PURPOSE: Returns TRUE if we managed to delete a certain service.
NATIVE FUNC BOOL NET_GAMESERVER_END_SERVICE( INT transactionId ) = "0x5ace3de15ef4a616"



/////////////////////////////////////////////////////////////////
////////////////////////// DELETE SLOT //////////////////////////
/////////////////////////////////////////////////////////////////

/// PURPOSE: Returns TRUE if we managed to start deleting a character.
NATIVE FUNC BOOL NET_GAMESERVER_DELETE_CHARACTER( int character, BOOL clearBank, INT reason ) = "0x104c4d01e9978f2b"

/// PURPOSE: Returns status of deleting a character.
NATIVE FUNC NET_GAMESERVER_TRANSACTION_STATUS NET_GAMESERVER_DELETE_CHARACTER_GET_STATUS( ) = "0x7b4873b0578ffe2d"

/// PURPOSE: Before Calling another character delete and before calling the commands_money command that sets 
///         telemtry call this command.
///
// NOTE: IT IS IMPORTANT THAT YOU TEST URE CODE AND MAKE SURE YOU ARE SETTING THE 
///      CORRECT NONCE SEED. FAILURE TO DO IT IS REALLY BAD....
///
NATIVE FUNC BOOL NET_GAMESERVER_DELETE_SET_TELEMETRY_NONCE_SEED( ) = "0x13bf5d027972316d"


////////////////////////////////////////////////////////////////////
////////////////////////// BANK TRANSFERS //////////////////////////
////////////////////////////////////////////////////////////////////

/// PURPOSE: Returns TRUE if we managed to start transfering cash from the bank to the wallet.
NATIVE FUNC BOOL NET_GAMESERVER_TRANSFER_BANK_TO_WALLET( INT slot, INT amount ) = "0xb20c7345f1489bf1"

/// PURPOSE: Returns status of the cash transfer.
NATIVE FUNC NET_GAMESERVER_TRANSACTION_STATUS NET_GAMESERVER_TRANSFER_BANK_TO_WALLET_GET_STATUS( ) = "0xc94b30f65c69ada8"

/// PURPOSE: Returns TRUE if we managed to start transfering cash from the wallet to the bank.
NATIVE FUNC BOOL NET_GAMESERVER_TRANSFER_WALLET_TO_BANK( int character, int amount ) = "0xca60478c0d089d74"

/// PURPOSE: Returns status of the cash transfer.
NATIVE FUNC NET_GAMESERVER_TRANSACTION_STATUS NET_GAMESERVER_TRANSFER_WALLET_TO_BANK_GET_STATUS( ) = "0xff1451ceaa01267c"

/// PURPOSE: Before Calling another cash transfer and before calling the commands_money command that sets 
///         telemetry call this command.
///
// NOTE: IT IS IMPORTANT THAT YOU TEST URE CODE AND MAKE SURE YOU ARE SETTING THE 
///      CORRECT NONCE SEED. FAILURE TO DO IT IS REALLY BAD....
///
NATIVE FUNC BOOL NET_GAMESERVER_TRANSFER_CASH_SET_TELEMETRY_NONCE_SEED( ) = "0x44c0c3ec2e3e2a3c"

////////////////////////////////////////////////////////////////////
////////////////////////// TELEMETRY ///////////////////////////////
////////////////////////////////////////////////////////////////////

/// PURPOSE: Before destroying successful transactions call this just before calling 
///         the commands_money.sch commands to setup the nonce for that telemetry.
///         This will permit to link the transaction to the telemetry. 
///
// NOTE: IT IS IMPORTANT THAT YOU TEST URE CODE AND MAKE SURE YOU ARE SETTING THE 
///      CORRECT NONCE SEED. FAILURE TO DO IT IS REALLY BAD....
///
NATIVE FUNC BOOL NET_GAMESERVER_SET_TELEMETRY_NONCE_SEED( INT transactionId ) = "0xcde1c8cef9603c08"


////////////////////////////////////////////////////////////////////
////////////////////////// HEARTBEAT //////////////////////////
////////////////////////////////////////////////////////////////////
NATIVE FUNC BOOL NET_GAMESERVER_ADD_CATALOG_ITEM_TO_HEARTBEAT( INT itemId, INT value, INT price ) = "0x07c2993b9e3fa833"

//eof


