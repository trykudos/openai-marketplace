---
name: kudos
description: Use for questions about the user's own credit cards in Kudos - which card to use at a merchant, what they spent or earned, unused card benefits and statement credits, card-linked offers, and negotiating a bill (internet, mobile, etc.) with their provider. Uses the Kudos tools.
---

# Kudos

Answer from the user's Kudos account with the Kudos tools; never guess rewards, balances, offers or
savings. Never show the user ids or tool names; say what is happening in plain words.

- **Which card at a merchant**: `recommend_card_for_purchase` with the merchant name or website.
- **"My card" without saying which**: `list_my_cards` first, then pass its card id to the other
  tools. Card ids are stable; don't list cards again in the same conversation.
- **Spending and rewards earned**: `get_transactions` (filter by card, merchant, dates). Free plans
  only see the last 30 days.
- **Unused benefits and credits**: `get_benefits`; PENDING and NEEDS_CONFIRMATION are outstanding.
- **Card-linked offers**: `get_card_linked_offers` (ACTIVE, EXPIRING, USED).

## Bill negotiation

The Kudos server's own instructions describe each step in detail; follow them. In order:

1. `get_bill_negotiation_merchants`: the user picks a merchant and service type.
2. `create_bill_negotiation`: says what information is still needed.
3. Gather it in natural questions (the name, the service address, the plan), not field by field,
   and save it with `set_bill_negotiation_checks`. Offer `save_bill_negotiation_preferences` for
   answers marked saveable.
4. Show the user a summary; once they confirm and say to start, call `start_bill_negotiation_run`
   once (if it warns, confirm with the user before `forceStart`).
5. Poll `get_bill_negotiation_status` about every 10 seconds and tell the user whenever something
   changes. When it finishes, share the summary, the savings and the call video link.
6. During the call:
   - A code or approval from the provider: ask the user right away and pass it to
     `submit_bill_negotiation_verification`.
   - Anything else the user tells you for the call (an account detail, a price they'd accept, a
     service to keep or drop): `add_bill_negotiation_call_context`.
7. Failed, or finished without savings: offer `retry_bill_negotiation`. Only cancel with
   `cancel_bill_negotiation` when the user asks.

Kudos does not move money, pay bills or apply for cards; say so if asked.
