# Pacing

Pacing is a tool that enables therapists to better manage and track their caseload. It is built for cases where there are therapy frequency limitations that need to be adhered to. For example, in the case of an [IEP (Individualized Education Program)](https://ambiki.com/glossary-concepts/iep), 504 plan, or a Service plan. This gem helps to calculate remaining visits as well as a therapist's current pace to meet visit mandates.

- 🐇 Ahead of pace
- 😁 On pace
- 🐢 Behind pace

## Getting started

**Ruby**

_Supports Ruby x.x.x and above_

```
gem install pacing
```

**Ruby on Rails**

Add this line to your application’s Gemfile:

```ruby
gem 'pacing'
```

## How it works

```ruby

school_plan = {
  school_plan_services: [
    {
      school_plan_type: "IEP", # string ('IEP', '504 Plan', 'Service Plan' )
      start_date: "01-01-2022", # string (mm-dd-yyyy)
      end_date: "01-01-2023", # string (mm-dd-yyyy)
      type_of_service: "Language Therapy", # string ('Language Therapy', 'Speech Therapy', 'Occupation Therapy', 'Physical Therapy', 'Feeding Therapy', 'Speech and Language Therapy')
      frequency: 6, # integer
      interval: "monthly", # string ('weekly', 'monthly', 'yearly')
      time_per_session_in_minutes: 30, # integer
      completed_visits_for_current_interval: 7, # integer
      extra_sessions_allowable: 1, # integer
      interval_for_extra_sessions_allowable: "monthly", # string ('weekly', 'monthly', 'yearly')
    },
    {
      school_plan_type: "IEP", # string ('IEP', '504 Plan', 'Service Plan' )
      start_date: "01-01-2022", # string (mm-dd-yyyy)
      end_date: "01-01-2023", # string (mm-dd-yyyy)
      type_of_service: "Physical Therapy", # string ('Language Therapy', 'Speech Therapy', 'Occupation Therapy', 'Physical Therapy', 'Feeding Therapy', 'Speech and Language Therapy')
      frequency: 6, # integer
      interval: "monthly", # string ('weekly', 'monthly', 'yearly')
      time_per_session_in_minutes: 30, # integer
      completed_visits_for_current_interval: 7, # integer
      extra_sessions_allowable: 1, # integer
      interval_for_extra_sessions_allowable: "monthly", # string ('weekly', 'monthly', 'yearly')
    }
  ]
}

date = '04-22-2022' # string (mm-dd-yyyy)
state = :us_tn
# default is `:us_tn` possible options :us_fl, :us_la, :us_ct, :us_de, :us_gu, :us_hi, :us_in, :us_ky, :us_nj, :us_nc, :us_nd, :us_pr, :us_tn, :us_ms, :us_id, :us_ar, :us_tx, :us_dc, :us_md, :us_va, :us_vt, :us_ak, :us_ca, :us_me, :us_ma, :us_al, :us_ga, :us_ne, :us_mo, :us_sc, :us_wv, :us_vi, :us_ut, :us_ri, :us_az, :us_co, :us_il, :us_mt, :us_nm, :us_ny, :us_oh, :us_pa, :us_mi, :us_mn, :us_nv, :us_or, :us_sd, :us_wa, :us_wi, :us_wy, :us_ia, :us_ks, :us_nh, :us_ok
non_business_days = ['04-25-2022'] # array of strings (mm-dd-yyyy)
summer_holidays = ["05-31-2022", "08-01-2022"] # [start-of-holiday-date, end-of-holiday-date] array of strings (mm-dd-yyyy)
mode = :liberal # default is :liberal, two possible options :strict, :liberal
paced = Pacing::Pacer.new(school_plan: school_plan, date: date, non_business_days: non_business_days, mode: :liberal, summer_holidays: summer_holidays, state: state)
paced.calculate

# Below is the result you will get when in liberal mode
=begin
=> [
    {
      discipline: 'Speech Therapy',
      remaining_visits: 0,
      used_visits: 7,
      expected_visits_at_date: 5,
      reset_date: '05-01-2022',
      pace: 2,
      pace_indicator: "🐇",
      pace_suggestion: "less than once per week"
    }, {
      discipline: 'Physical Therapy',
      remaining_visits: 0,
      expected_visits_at_date: 5,
      used_visits: 7,
      reset_date: '05-01-2022',
      pace: 2,
      pace_indicator: "🐇",
      pace_suggestion: "less than once per week"
    }
  ]
=end

# Below is the result you will get when in strict mode
# in strict mode the reset date for intervals of month and week is determined by the start date of the school plan service. e.g the reset date in the 6th month for a start date of "05-11-2022" for an interva of `month` will be "06-11-2022" whereas for `:liberal` mode it will be "06-01-2022"
=begin
=> [
    {
      discipline: 'Speech Therapy',
      remaining_visits: 0,
      used_visits: 7,
      expected_visits_at_date: 3,
      reset_date: '05-11-2022',
      pace: 4,
      pace_indicator: "🐇",
      pace_suggestion: "less than once per week"
    }, {
      discipline: 'Physical Therapy',
      remaining_visits: 0,
      expected_visits_at_date: 3,
      used_visits: 7,
      reset_date: '05-11-2022',
      pace: 4,
      pace_indicator: "🐇",
      pace_suggestion: "less than once per week"
    }
  ]
=end
```

It is important to note that the `pace` is hugely influenced by the `summer_holidays` period and the `mode` in which it is calculated.

## Data Types

Pacing accepts input which consists of a school_plan, a date and a non_business_day variable. The school_plan variable is a hash that includes the various school plan services that the client received, the date is a string and the non_business_days variable is an array of dates.

The output received is a hash that contains all the necessary information that is useful to the user.

The following list shows the various variables and what they consist of:

1. Input
   - `school_plan_type` is a string.
   - `start_date` is a string.
   - `end_date` is a string.
   - `type_of_service` is a string.
   - `frequency` is an integer.
   - `interval` is a string.
   - `time_per_session_in_minutes` is an integer.
   - `extra_sessions_allowable` is an integer.
   - `interval_for_extra_sessions_allowable` is a string.
2. Output
   - `discipline`: is a string.
   - `remaining_visits`: is an integer.
   - `used_visits`: is an integer.
   - `expected_visits_at_date`: is an integer.
   - `reset_date`: is a string.
   - `pace`: is an integer.
   - `pace_indicator`: is an emoji string.
   - `pace_suggestion`: is a string.
   - `reset_date` is a string.
   - `pace` is an integer.
   - `pace_indicator` is a string.

## Terminology

- **IEP (Individualized Education Program)**: Individualized Education Programs (IEPs) are required by law for every student who receives special education services and are developed on an annual basis. The IEP is an educational document that the school generates. The therapist is bound to the frequency on the IEP, and the insurance companies will not pay for anything above or beyond what is on the IEP. It is a blueprint for a student’s special education experience in a public school. The plan must ensure that the child receives a free appropriate public education, (FAPE).
- **504 Plan**: 504 plans are formal plans that schools develop to give kids with disabilities the support they need. That covers any condition that limits daily activities in a major way. These plans prevent discrimination and they protect the rights of kids with disabilities in school. They are covered under Section 504 of the Rehabilitation Act, a civil rights law.
- **Service Plan**: A plan paid for by the local school district for students with disabilities who attend private schools. A Service plan does not have to ensure a child is provided with FAPE (free appropriate public education). A Service plan spells out the special education and related services the LEA will make available to a child. These services are provided at no cost to parents. But the student may not be able to receive these services at the private school. Instead, the LEA can require him to go to a public school for services like speech therapy sessions. [§34 CFR 300.130 through §300.144 of IDEA](https://sites.ed.gov/idea/files/CWD_Enrolled_by_Their_Parents_in_Private_Schools_11-16-06.pdf) is a specific section that describes how services are provided to kids in private school.

## Testing

- `bundle exec rspec`

## Contributing

Everyone is encouraged to help improve this project. Here are a few ways you can help:

- [Report bugs](https://github.com/Ambiki/pacing/issues)
- Fix bugs and [submit pull requests](https://github.com/Ambiki/pacing/pulls)
- Write, clarify, or fix documentation
- Suggest or add new features

To get started with development:

1. Fork it ( https://github.com/Ambiki/pacing/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Publishing

1. gem build pacing.gemspec
2. gem push pacing-x.x.x.gem

## License

The MIT License (MIT)

Copyright (c) 2022 Ambitious Idea Labs

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
