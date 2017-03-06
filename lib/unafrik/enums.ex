import EctoEnum

defenum SubscriptionStatusEnum, subscribed: 0, unsubscribed: 1
defenum UserStatusEnum, active: 0, disabled: 1
defenum DefaultStatusEnum, active: 0, disabled: 1
defenum RecurrenceEnum, daily: 0, weekly: 1, monthly: 2, yearly: 3
defenum RequestTypeEnum, pto: 0, remote: 1, leave: 2
defenum RequestStatusEnum, pending: 0, declined: 1, approved: 2

# , weekdays: 4 # TODO: Have to come back to that
defenum(
  InquiryTypeEnum,
  "I need billing assistance": 0,
  "I have questions before signing up": 1,
  "I have a suggestion or a request": 2,
  "I am having problem registering": 3,
  "Press or media inquiry": 4,
  "I have a general comment or question": 5
)
