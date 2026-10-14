---
name: kudos
description: Use for questions about the user's own credit cards in Kudos - which card to use at a merchant, what they spent or earned, unused card benefits and statement credits, card-linked offers, and negotiating a bill (internet, mobile, etc.) with their provider. Uses the Kudos tools.
---

# Kudos

Answer from the user's Kudos account with the Kudos tools; never guess rewards, balances, offers or
savings.

- **Which card at a merchant**: `recommend_card_for_purchase` with the merchant name or website.
- **"My card" without saying which**: `list_my_cards` first, then pass its card id to the other
  tools. Card ids are stable; don't list cards again in the same conversation.
- **Spending and rewards earned**: `get_transactions` (filter by card, merchant, dates). Free plans
  only see the last 30 days.
- **Unused benefits and credits**: `get_benefits`; PENDING and NEEDS_CONFIRMATION are outstanding.
- **Card-linked offers**: `get_card_linked_offers` (ACTIVE, EXPIRING, USED).
- **Bill negotiation**: `get_bill_negotiation_merchants` -> `create_bill_negotiation` -> gather and
  confirm the checks with the user -> `start_bill_negotiation_run` only once the user says to start
  -> poll `get_bill_negotiation_status`. If the provider sends a code or approval during the call,
  ask the user right away and pass it to `submit_bill_negotiation_verification`. Only cancel with
  `cancel_bill_negotiation` when the user asks.

Kudos does not move money, pay bills or apply for cards; say so if asked.
