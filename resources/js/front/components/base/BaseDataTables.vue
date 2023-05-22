<template>
  <div class="card">
    <div class="card-header">
      <h4 class="card-title">{{ pluralize(entity, true) }}</h4>
      <div class="d-flex justify-content-between align-items-center mt-2">
        <div class="input-group" style="width: fit-content">
          <div class="input-group-prepend">
            <label class="input-group-text" for="zones">Timezone</label>
          </div>
          <select id="zones" name="zones" class="custom-select" v-model="selectedZone">
            <option :value="index" v-for="(zone, index) in zones" :key="index">
              {{ zone.replace("_", " ") }}
            </option>
          </select>
        </div>
        <div class="d-flex justify-content-between align-items-center">
          <button
            type="button"
            class="btn btn-info"
            @click="$emit('create-entity')"
            v-if="canStore"
          >
            Create {{ ucwords(entity) }}
          </button>
          <slot name="header-buttons"></slot>
        </div>
      </div>
    </div>
    <div class="card-content collapse show">
      <div class="card-body card-dashboard table-responsive">
        <table
          id="datatable"
          class="table table-bordered"
          v-if="!isFetching"
          data-export-title="test"
        >
          <thead>
            <tr>
              <slot name="header-cols"></slot>
            </tr>
          </thead>
          <tbody>
            <slot name="body-rows" :setZone="setZone"></slot>
          </tbody>
        </table>
      </div>
    </div>
  </div>
</template>

<script>
import { watch, nextTick, computed, ref, onBeforeMount } from "vue";
export default {
  props: {
    fetching: Boolean,
    entity: String,
    columns: Array,
    objects: Array,
    type: {
      type: String,
      required: false,
    },
    extraOptions: {
      type: Object,
      required: false,
    },
    isLarge: {
      type: Boolean,
      required: false,
      default: false,
    },
  },
  setup(props, { attrs }) {
    const zones = [
      "Pacific/Midway",
      "Pacific/Niue",
      "Pacific/Pago_Pago",
      "America/Adak",
      "Pacific/Honolulu",
      "Pacific/Rarotonga",
      "Pacific/Tahiti",
      "Pacific/Marquesas",
      "America/Anchorage",
      "America/Juneau",
      "America/Metlakatla",
      "America/Nome",
      "America/Sitka",
      "America/Yakutat",
      "Pacific/Gambier",
      "America/Los_Angeles",
      "America/Tijuana",
      "America/Vancouver",
      "Pacific/Pitcairn",
      "America/Boise",
      "America/Cambridge_Bay",
      "America/Chihuahua",
      "America/Creston",
      "America/Dawson",
      "America/Dawson_Creek",
      "America/Denver",
      "America/Edmonton",
      "America/Fort_Nelson",
      "America/Hermosillo",
      "America/Inuvik",
      "America/Mazatlan",
      "America/Ojinaga",
      "America/Phoenix",
      "America/Whitehorse",
      "America/Yellowknife",
      "America/Bahia_Banderas",
      "America/Belize",
      "America/Chicago",
      "America/Costa_Rica",
      "America/El_Salvador",
      "America/Guatemala",
      "America/Indiana/Knox",
      "America/Indiana/Tell_City",
      "America/Managua",
      "America/Matamoros",
      "America/Menominee",
      "America/Merida",
      "America/Mexico_City",
      "America/Monterrey",
      "America/North_Dakota/Beulah",
      "America/North_Dakota/Center",
      "America/North_Dakota/New_Salem",
      "America/Rainy_River",
      "America/Rankin_Inlet",
      "America/Regina",
      "America/Resolute",
      "America/Swift_Current",
      "America/Tegucigalpa",
      "America/Winnipeg",
      "Pacific/Easter",
      "Pacific/Galapagos",
      "America/Atikokan",
      "America/Bogota",
      "America/Cancun",
      "America/Cayman",
      "America/Detroit",
      "America/Eirunepe",
      "America/Grand_Turk",
      "America/Guayaquil",
      "America/Havana",
      "America/Indiana/Indianapolis",
      "America/Indiana/Marengo",
      "America/Indiana/Petersburg",
      "America/Indiana/Vevay",
      "America/Indiana/Vincennes",
      "America/Indiana/Winamac",
      "America/Iqaluit",
      "America/Jamaica",
      "America/Kentucky/Louisville",
      "America/Kentucky/Monticello",
      "America/Lima",
      "America/Nassau",
      "America/New_York",
      "America/Nipigon",
      "America/Panama",
      "America/Pangnirtung",
      "America/Port-au-Prince",
      "America/Rio_Branco",
      "America/Thunder_Bay",
      "America/Toronto",
      "America/Anguilla",
      "America/Antigua",
      "America/Aruba",
      "America/Asuncion",
      "America/Barbados",
      "America/Blanc-Sablon",
      "America/Boa_Vista",
      "America/Campo_Grande",
      "America/Caracas",
      "America/Cuiaba",
      "America/Curacao",
      "America/Dominica",
      "America/Glace_Bay",
      "America/Goose_Bay",
      "America/Grenada",
      "America/Guadeloupe",
      "America/Guyana",
      "America/Halifax",
      "America/Kralendijk",
      "America/La_Paz",
      "America/Lower_Princes",
      "America/Manaus",
      "America/Marigot",
      "America/Martinique",
      "America/Moncton",
      "America/Montserrat",
      "America/Porto_Velho",
      "America/Port_of_Spain",
      "America/Puerto_Rico",
      "America/Santiago",
      "America/Santo_Domingo",
      "America/St_Barthelemy",
      "America/St_Kitts",
      "America/St_Lucia",
      "America/St_Thomas",
      "America/St_Vincent",
      "America/Thule",
      "America/Tortola",
      "Atlantic/Bermuda",
      "America/St_Johns",
      "America/Araguaina",
      "America/Argentina/Buenos_Aires",
      "America/Argentina/Catamarca",
      "America/Argentina/Cordoba",
      "America/Argentina/Jujuy",
      "America/Argentina/La_Rioja",
      "America/Argentina/Mendoza",
      "America/Argentina/Rio_Gallegos",
      "America/Argentina/Salta",
      "America/Argentina/San_Juan",
      "America/Argentina/San_Luis",
      "America/Argentina/Tucuman",
      "America/Argentina/Ushuaia",
      "America/Bahia",
      "America/Belem",
      "America/Cayenne",
      "America/Fortaleza",
      "America/Godthab",
      "America/Maceio",
      "America/Miquelon",
      "America/Montevideo",
      "America/Paramaribo",
      "America/Punta_Arenas",
      "America/Recife",
      "America/Santarem",
      "America/Sao_Paulo",
      "Antarctica/Palmer",
      "Antarctica/Rothera",
      "Atlantic/Stanley",
      "America/Noronha",
      "Atlantic/South_Georgia",
      "America/Scoresbysund",
      "Atlantic/Azores",
      "Atlantic/Cape_Verde",
      "Africa/Abidjan",
      "Africa/Accra",
      "Africa/Bamako",
      "Africa/Banjul",
      "Africa/Bissau",
      "Africa/Casablanca",
      "Africa/Conakry",
      "Africa/Dakar",
      "Africa/El_Aaiun",
      "Africa/Freetown",
      "Africa/Lome",
      "Africa/Monrovia",
      "Africa/Nouakchott",
      "Africa/Ouagadougou",
      "Africa/Sao_Tome",
      "America/Danmarkshavn",
      "Antarctica/Troll",
      "Atlantic/Canary",
      "Atlantic/Faroe",
      "Atlantic/Madeira",
      "Atlantic/Reykjavik",
      "Atlantic/St_Helena",
      "Europe/Dublin",
      "Europe/Guernsey",
      "Europe/Isle_of_Man",
      "Europe/Jersey",
      "Europe/Lisbon",
      "Europe/London",
      "Africa/Algiers",
      "Africa/Bangui",
      "Africa/Brazzaville",
      "Africa/Ceuta",
      "Africa/Douala",
      "Africa/Kinshasa",
      "Africa/Lagos",
      "Africa/Libreville",
      "Africa/Luanda",
      "Africa/Malabo",
      "Africa/Ndjamena",
      "Africa/Niamey",
      "Africa/Porto-Novo",
      "Africa/Tunis",
      "Africa/Windhoek",
      "Arctic/Longyearbyen",
      "Europe/Amsterdam",
      "Europe/Andorra",
      "Europe/Belgrade",
      "Europe/Berlin",
      "Europe/Bratislava",
      "Europe/Brussels",
      "Europe/Budapest",
      "Europe/Copenhagen",
      "Europe/Gibraltar",
      "Europe/Ljubljana",
      "Europe/Luxembourg",
      "Europe/Madrid",
      "Europe/Malta",
      "Europe/Monaco",
      "Europe/Oslo",
      "Europe/Paris",
      "Europe/Podgorica",
      "Europe/Prague",
      "Europe/Rome",
      "Europe/San_Marino",
      "Europe/Sarajevo",
      "Europe/Skopje",
      "Europe/Stockholm",
      "Europe/Tirane",
      "Europe/Vaduz",
      "Europe/Vatican",
      "Europe/Vienna",
      "Europe/Warsaw",
      "Europe/Zagreb",
      "Europe/Zurich",
      "Africa/Blantyre",
      "Africa/Bujumbura",
      "Africa/Cairo",
      "Africa/Gaborone",
      "Africa/Harare",
      "Africa/Johannesburg",
      "Africa/Juba",
      "Africa/Khartoum",
      "Africa/Kigali",
      "Africa/Lubumbashi",
      "Africa/Lusaka",
      "Africa/Maputo",
      "Africa/Maseru",
      "Africa/Mbabane",
      "Africa/Tripoli",
      "Asia/Amman",
      "Asia/Beirut",
      "Asia/Damascus",
      "Asia/Famagusta",
      "Asia/Gaza",
      "Asia/Hebron",
      "Asia/Jerusalem",
      "Asia/Nicosia",
      "Europe/Athens",
      "Europe/Bucharest",
      "Europe/Chisinau",
      "Europe/Helsinki",
      "Europe/Kaliningrad",
      "Europe/Kiev",
      "Europe/Mariehamn",
      "Europe/Riga",
      "Europe/Sofia",
      "Europe/Tallinn",
      "Europe/Uzhgorod",
      "Europe/Vilnius",
      "Europe/Zaporozhye",
      "Africa/Addis_Ababa",
      "Africa/Asmara",
      "Africa/Dar_es_Salaam",
      "Africa/Djibouti",
      "Africa/Kampala",
      "Africa/Mogadishu",
      "Africa/Nairobi",
      "Antarctica/Syowa",
      "Asia/Aden",
      "Asia/Baghdad",
      "Asia/Bahrain",
      "Asia/Kuwait",
      "Asia/Qatar",
      "Asia/Riyadh",
      "Europe/Istanbul",
      "Europe/Kirov",
      "Europe/Minsk",
      "Europe/Moscow",
      "Europe/Simferopol",
      "Europe/Volgograd",
      "Indian/Antananarivo",
      "Indian/Comoro",
      "Indian/Mayotte",
      "Asia/Tehran",
      "Asia/Baku",
      "Asia/Dubai",
      "Asia/Muscat",
      "Asia/Tbilisi",
      "Asia/Yerevan",
      "Europe/Astrakhan",
      "Europe/Samara",
      "Europe/Saratov",
      "Europe/Ulyanovsk",
      "Indian/Mahe",
      "Indian/Mauritius",
      "Indian/Reunion",
      "Asia/Kabul",
      "Antarctica/Mawson",
      "Asia/Aqtau",
      "Asia/Aqtobe",
      "Asia/Ashgabat",
      "Asia/Atyrau",
      "Asia/Dushanbe",
      "Asia/Karachi",
      "Asia/Oral",
      "Asia/Qyzylorda",
      "Asia/Samarkand",
      "Asia/Tashkent",
      "Asia/Yekaterinburg",
      "Indian/Kerguelen",
      "Indian/Maldives",
      "Asia/Colombo",
      "Asia/Kolkata",
      "Asia/Kathmandu",
      "Antarctica/Vostok",
      "Asia/Almaty",
      "Asia/Bishkek",
      "Asia/Dhaka",
      "Asia/Omsk",
      "Asia/Qostanay",
      "Asia/Thimphu",
      "Asia/Urumqi",
      "Indian/Chagos",
      "Asia/Yangon",
      "Indian/Cocos",
      "Antarctica/Davis",
      "Asia/Bangkok",
      "Asia/Barnaul",
      "Asia/Hovd",
      "Asia/Ho_Chi_Minh",
      "Asia/Jakarta",
      "Asia/Krasnoyarsk",
      "Asia/Novokuznetsk",
      "Asia/Novosibirsk",
      "Asia/Phnom_Penh",
      "Asia/Pontianak",
      "Asia/Tomsk",
      "Asia/Vientiane",
      "Indian/Christmas",
      "Asia/Brunei",
      "Asia/Choibalsan",
      "Asia/Hong_Kong",
      "Asia/Irkutsk",
      "Asia/Kuala_Lumpur",
      "Asia/Kuching",
      "Asia/Macau",
      "Asia/Makassar",
      "Asia/Manila",
      "Asia/Shanghai",
      "Asia/Singapore",
      "Asia/Taipei",
      "Asia/Ulaanbaatar",
      "Australia/Perth",
      "Australia/Eucla",
      "Asia/Chita",
      "Asia/Dili",
      "Asia/Jayapura",
      "Asia/Khandyga",
      "Asia/Pyongyang",
      "Asia/Seoul",
      "Asia/Tokyo",
      "Asia/Yakutsk",
      "Pacific/Palau",
      "Australia/Adelaide",
      "Australia/Broken_Hill",
      "Australia/Darwin",
      "Antarctica/DumontDUrville",
      "Antarctica/Macquarie",
      "Asia/Ust-Nera",
      "Asia/Vladivostok",
      "Australia/Brisbane",
      "Australia/Currie",
      "Australia/Hobart",
      "Australia/Lindeman",
      "Australia/Melbourne",
      "Australia/Sydney",
      "Pacific/Chuuk",
      "Pacific/Guam",
      "Pacific/Port_Moresby",
      "Pacific/Saipan",
      "Australia/Lord_Howe",
      "Antarctica/Casey",
      "Asia/Magadan",
      "Asia/Sakhalin",
      "Asia/Srednekolymsk",
      "Pacific/Bougainville",
      "Pacific/Efate",
      "Pacific/Guadalcanal",
      "Pacific/Kosrae",
      "Pacific/Norfolk",
      "Pacific/Noumea",
      "Pacific/Pohnpei",
      "Antarctica/McMurdo",
      "Asia/Anadyr",
      "Asia/Kamchatka",
      "Pacific/Auckland",
      "Pacific/Fiji",
      "Pacific/Funafuti",
      "Pacific/Kwajalein",
      "Pacific/Majuro",
      "Pacific/Nauru",
      "Pacific/Tarawa",
      "Pacific/Wake",
      "Pacific/Wallis",
      "Pacific/Chatham",
      "Pacific/Apia",
      "Pacific/Enderbury",
      "Pacific/Fakaofo",
      "Pacific/Tongatapu",
      "Pacific/Kiritimati",
    ];
    const selectedZone = ref(287);

    function setZone(date) {
      return new Date(date)
        .toLocaleString("en-US", { timeZone: zones[selectedZone.value] })
        .replace(/:\d+\s/g, " ")
        .replace(",", "")
        .replaceAll("/", "-");
    }

    const buttons = {
      print: {
        text: "<i class='fas fa-print'></i>",
        autoPrint: false,
      },
      excelHtml5: {
        text: "<i class='fa fa-file-excel-o'></i>",
      },
      pdfHtml5: {
        text: "<i class='fas fa-file-pdf'></i>",
        format: {
          body: function (data) {
            if (/<.*?>/gi.test(data)) {
              data = data
                .replace(/<.*?>/gi, "")
                .replace(/  |\r\n|\r/gm, "")
                .replace(/\n/gm, " ");
            }
            const arabic = /[\u0600-\u06FF]/;
            if (arabic.test(data)) {
              return data.split(" ").reverse().join(" ");
            }
            return data;
          },
        },
        customize: function (doc) {
          doc.content[1].table.widths = Array(doc.content[1].table.body[0].length + 1)
            .join("*")
            .split("");
          doc.styles.tableBodyEven.alignment = "center";
          doc.styles.tableBodyOdd.alignment = "center";
          doc.defaultStyle.font = "Amiri";
          doc.content.unshift({
            margin: [0, 0, 0, 20],
            alignment: "right",
            width: 50,
            height: 50,
            image:
              "data:image/jpeg;base64,/9j/4AAQSkZJRgABAQEBLAEsAAD/7QAsUGhvdG9zaG9wIDMuMAA4QklNA+0AAAAAABABLAAAAAEAAQEsAAAAAQAB/+FBzGh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC8APD94cGFja2V0IGJlZ2luPSLvu78iIGlkPSJXNU0wTXBDZWhpSHpyZVN6TlRjemtjOWQiPz4KPHg6eG1wbWV0YSB4bWxuczp4PSJhZG9iZTpuczptZXRhLyIgeDp4bXB0az0iQWRvYmUgWE1QIENvcmUgNS41LWMwMTQgNzkuMTUxNzM5LCAyMDEzLzA0LzAzLTEyOjEyOjE1ICAgICAgICAiPgogICA8cmRmOlJERiB4bWxuczpyZGY9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkvMDIvMjItcmRmLXN5bnRheC1ucyMiPgogICAgICA8cmRmOkRlc2NyaXB0aW9uIHJkZjphYm91dD0iIgogICAgICAgICAgICB4bWxuczpkYz0iaHR0cDovL3B1cmwub3JnL2RjL2VsZW1lbnRzLzEuMS8iCiAgICAgICAgICAgIHhtbG5zOnhtcD0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wLyIKICAgICAgICAgICAgeG1sbnM6eG1wR0ltZz0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL2cvaW1nLyIKICAgICAgICAgICAgeG1sbnM6eG1wTU09Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9tbS8iCiAgICAgICAgICAgIHhtbG5zOnN0UmVmPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvc1R5cGUvUmVzb3VyY2VSZWYjIgogICAgICAgICAgICB4bWxuczpzdEV2dD0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL3NUeXBlL1Jlc291cmNlRXZlbnQjIgogICAgICAgICAgICB4bWxuczppbGx1c3RyYXRvcj0iaHR0cDovL25zLmFkb2JlLmNvbS9pbGx1c3RyYXRvci8xLjAvIgogICAgICAgICAgICB4bWxuczpwZGY9Imh0dHA6Ly9ucy5hZG9iZS5jb20vcGRmLzEuMy8iPgogICAgICAgICA8ZGM6Zm9ybWF0PmltYWdlL2pwZWc8L2RjOmZvcm1hdD4KICAgICAgICAgPGRjOnRpdGxlPgogICAgICAgICAgICA8cmRmOkFsdD4KICAgICAgICAgICAgICAgPHJkZjpsaSB4bWw6bGFuZz0ieC1kZWZhdWx0Ij7YtNi52KfYsSDYp9mE2YbZh9in2KbZiiAtINio2LnYryDYp9mE2KrYudiv2YrZhDwvcmRmOmxpPgogICAgICAgICAgICA8L3JkZjpBbHQ+CiAgICAgICAgIDwvZGM6dGl0bGU+CiAgICAgICAgIDx4bXA6TWV0YWRhdGFEYXRlPjIwMTQtMDktMjJUMTQ6NDg6MTUrMDM6MDA8L3htcDpNZXRhZGF0YURhdGU+CiAgICAgICAgIDx4bXA6TW9kaWZ5RGF0ZT4yMDE0LTA5LTIyVDExOjQ4OjIyWjwveG1wOk1vZGlmeURhdGU+CiAgICAgICAgIDx4bXA6Q3JlYXRlRGF0ZT4yMDE0LTA5LTIyVDE0OjQ4OjE1KzAzOjAwPC94bXA6Q3JlYXRlRGF0ZT4KICAgICAgICAgPHhtcDpDcmVhdG9yVG9vbD5BZG9iZSBJbGx1c3RyYXRvciBDQyAoV2luZG93cyk8L3htcDpDcmVhdG9yVG9vbD4KICAgICAgICAgPHhtcDpUaHVtYm5haWxzPgogICAgICAgICAgICA8cmRmOkFsdD4KICAgICAgICAgICAgICAgPHJkZjpsaSByZGY6cGFyc2VUeXBlPSJSZXNvdXJjZSI+CiAgICAgICAgICAgICAgICAgIDx4bXBHSW1nOndpZHRoPjI1NjwveG1wR0ltZzp3aWR0aD4KICAgICAgICAgICAgICAgICAgPHhtcEdJbWc6aGVpZ2h0PjE3NjwveG1wR0ltZzpoZWlnaHQ+CiAgICAgICAgICAgICAgICAgIDx4bXBHSW1nOmZvcm1hdD5KUEVHPC94bXBHSW1nOmZvcm1hdD4KICAgICAgICAgICAgICAgICAgPHhtcEdJbWc6aW1hZ2U+LzlqLzRBQVFTa1pKUmdBQkFnRUFTQUJJQUFELzdRQXNVR2h2ZEc5emFHOXdJRE11TUFBNFFrbE5BKzBBQUFBQUFCQUFTQUFBQUFFQSYjeEE7QVFCSUFBQUFBUUFCLys0QURrRmtiMkpsQUdUQUFBQUFBZi9iQUlRQUJnUUVCQVVFQmdVRkJna0dCUVlKQ3dnR0JnZ0xEQW9LQ3dvSyYjeEE7REJBTURBd01EQXdRREE0UEVBOE9EQk1URkJRVEV4d2JHeHNjSHg4Zkh4OGZIeDhmSHdFSEJ3Y05EQTBZRUJBWUdoVVJGUm9mSHg4ZiYjeEE7SHg4Zkh4OGZIeDhmSHg4Zkh4OGZIeDhmSHg4Zkh4OGZIeDhmSHg4Zkh4OGZIeDhmSHg4Zkh4OGZIeDhmLzhBQUVRZ0FzQUVBQXdFUiYjeEE7QUFJUkFRTVJBZi9FQWFJQUFBQUhBUUVCQVFFQUFBQUFBQUFBQUFRRkF3SUdBUUFIQ0FrS0N3RUFBZ0lEQVFFQkFRRUFBQUFBQUFBQSYjeEE7QVFBQ0F3UUZCZ2NJQ1FvTEVBQUNBUU1EQWdRQ0JnY0RCQUlHQW5NQkFnTVJCQUFGSVJJeFFWRUdFMkVpY1lFVU1wR2hCeFd4UWlQQiYjeEE7VXRIaE14Wmk4Q1J5Z3ZFbFF6UlRrcUt5WTNQQ05VUW5rNk96TmhkVVpIVEQwdUlJSm9NSkNoZ1poSlJGUnFTMFZ0TlZLQnJ5NC9QRSYjeEE7MU9UMFpYV0ZsYVcxeGRYbDlXWjJocGFtdHNiVzV2WTNSMWRuZDRlWHA3ZkgxK2YzT0VoWWFIaUltS2k0eU5qbytDazVTVmxwZVltWiYjeEE7cWJuSjJlbjVLanBLV21wNmlwcXF1c3JhNnZvUkFBSUNBUUlEQlFVRUJRWUVDQU1EYlFFQUFoRURCQ0VTTVVFRlVSTmhJZ1p4Z1pFeSYjeEE7b2JId0ZNSFI0U05DRlZKaWN2RXpKRFJEZ2hhU1V5V2lZN0xDQjNQU05lSkVneGRVa3dnSkNoZ1pKalpGR2lka2RGVTM4cU96d3lncCYjeEE7MCtQemhKU2t0TVRVNVBSbGRZV1ZwYlhGMWVYMVJsWm1kb2FXcHJiRzF1YjJSMWRuZDRlWHA3ZkgxK2YzT0VoWWFIaUltS2k0eU5qbyYjeEE7K0RsSldXbDVpWm1wdWNuWjZma3FPa3BhYW5xS21xcTZ5dHJxK3YvYUFBd0RBUUFDRVFNUkFEOEE5VTRxN0ZYWXE3RlhZcTdGWFlxNyYjeEE7RlhZcTdGWFlxN0ZYWXE3RlhZcTdGWFlxN0ZXTCtjZnpMOG5lVVlpZFl2bEYxU3FXRU5KTGx1NC9kZy9DRDJMa0QzeTNIaGxQa0d2SiYjeEE7bGpEbVhpY241eTZ0NTEvTWp5MVpXcVBwMmd4NmpiRVdmT3JUTUpRUTh4V2dOT3k5QjduTTM4dUlRSjVtbkNHcE01Z0RZUHBUTmE3RiYjeEE7Mkt1eFYyS3V4VjJLdXhWMkt1eFYyS29MVjlhMG5Scko3N1ZidUt5dEkvdFRUT0VXdmdLOVNld0crU2pFazBFR1FBc3ZBL3pUL3dDYyYjeEE7aGt2clI5SThtU1N4UnkxUzYxWmw5TnloMjR3QS9FdGU3a0J2RHh6UHdhU2pjbkF6NnZhby9OOUU1cm5ZT3hWMkt1eFYyS3V4VjJLdSYjeEE7eFYyS3V4VjJLdXhWMkt1eFYyS3V4VjJLdk9QejI4ODZoNVU4bktkTGs5SFV0U20rcXd6ajdVU2NTMGtpZjVWQUZIaFd2Yk1uUzRoTyYjeEE7Vy9JT1BxY3BoSGJtK1I1cHBwNVhtbWthV2FRbHBKSEpabVk3a2tuY2s1dHdIVGsyeVQ4c1AvSmkrVy8rMmpiZjhuQmxXZjZEN203VCYjeEE7L1dIMjNta2QwN0ZYWXE3RlhZcTdGWFlxN0ZYWXFrUG52elFubGJ5bHFXdk1nbGF6aXJERWVqU3lNSTRnMU4rSmR4WDJ5ekZEaWtBdyYjeEE7eVQ0WWt2akh6SjVwMS96SnFEMyt0WHNsM094SlVPZmdqQk5lTWFmWlJmWUROekNBaUtEcFo1SlNObEtjbXdmb0ZuUHZRT3hWMkt1eCYjeEE7VjJLdXhWMkt1eFYyS3V4VjJLdXhWMkt1eFYyS3V4VjJLdkRmK2NxZitPRm9QL01WTi95YkdaMmg1bHd0ZDlJOTc1dnpaT3NaUCtXSCYjeEE7L2t4ZkxmOEEyMGJiL2s0TXF6L1FmYzNhZjZ3KzI4MGp1bllxN0ZYWXE3RlhZcTdGWFlxN0ZYbTMvT1EvL2tyZFEvNHpXMy9KNWN5ZCYjeEE7Si9lQng5WC9BSFpmSTJiZDA3c1Zmb0ZuUHZRT3hWMkt1eFYyS3V4VjJLdXhWMkt1eFYyS3V4VjJLdXhWMkt1eFYyS3ZEZjhBbktuLyYjeEE7QUk0V2cvOEFNVk4veWJHWjJoNWx3dGQ5STk3NXZ6Wk9zWlArV0gva3hmTGYvYlJ0ditUZ3lyUDlCOXpkcC9yRDdielNPNmRpcnNWZCYjeEE7aXJzVmRpcnNWZGlyc1ZlYmY4NUQvd0RrcmRRLzR6VzMvSjVjeWRKL2VCeDlYL2RsOGpadDNUdXhWK2dXYys5QTdGWFlxN0ZYWXE3RiYjeEE7WFlxN0ZYWXE3RlhZcTdGWFlxN0ZYWXE3RlhZcThOLzV5cC80NFdnLzh4VTMvSnNabmFIbVhDMTMwajN2bS9OazZ4ay81WWYrVEY4dCYjeEE7L3dEYlJ0ditUZ3lyUDlCOXpkcC9yRDdielNPNmRpcnNWZGlyc1ZkaXJzVmRpcnNWZWJmODVELytTdDFEL2pOYmY4bmx6SjBuOTRISCYjeEE7MWY4QWRsOGpadDNUdXhWK2dXYys5QTdGWFlxN0ZYWXE3RlhZcTdGWFlxN0ZYWXE3RlhZcTdGWFlxN0ZYWXE4Ti93Q2NxZjhBamhhRCYjeEE7L3dBeFUzL0pzWm5hSG1YQzEzMGozdm0vTms2eGsvNVlmK1RGOHQvOXRHMi81T0RLcy8wSDNOMm4rc1B0dk5JN3AyS3V4VjJLdXhWMiYjeEE7S3V4VjJLdXhWNXQvemtQL0FPU3QxRC9qTmJmOG5sekowbjk0SEgxZjkyWHlObTNkTzdGWDZCWno3MERzVmRpcnNWZGlyc1ZkaXJzViYjeEE7ZGlyc1ZTeTY4eitYTFZpbHhxZHRHNDZvWlU1Q24rU0RYSkNFajBhSjZuRkhZeUErS0cveHo1Ui82dXNIL0JmMlpMd3BkelgrZXcveiYjeEE7dzcvSFBsSC9BS3VzSC9CZjJZK0ZMdVg4OWgvbmgzK09mS1AvQUZkWVArQy9zeDhLWGN2NTdEL1BEdjhBSFBsSC9xNndmOEYvWmo0VSYjeEE7dTVmejJIK2VIZjQ1OG8vOVhXRC9BSUwrekh3cGR5L25zUDhBUER2OGMrVWYrcnJCL3dBRi9aajRVdTVmejJIK2VIa1AvT1JlbzJYbSYjeEE7RFI5SGkwV1piK1MzdUpYbVNINGlxbEFBU016TkhFeEp0eE5ack1Vb2lwRG0rZjdqVDcrMkZiaTNsaUhpNk1vKzhqTThGd281SW5rVSYjeEE7L3dEeXcvOEFKaStXL3dEdG8yMy9BQ2NHVjUvb1B1Y25UL1dIMjNta2QwN0ZYWXE3RlhZcTdGWFlxN0ZYWXE4Mi93Q2NoLzhBeVZ1byYjeEE7ZjhacmIvazh1Wk9rL3ZBNCtyL3V5K1JzMjdwM1lxK3V2UGY1bDNWamV5NlZvM0Zab1R4dUx0Z0c0djNSRk8zdzl5YzFPSEJZc3RuYSYjeEE7SGFoaEl3eDh4ekx6MjU4MCtaTGx5MDJxWFRFOWhLNnJ2NEtwQXpKR09JNk9rbnJNMHVjcGZORGZwZlZmK1cyZi9rYS85Y2x3RHVZZSYjeEE7UGsvbkg1dS9TK3EvOHRzLy9JMS82NDhBN2w4ZkovT1B6ZCtsOVYvNWJaLytSci8xeDRCM0w0K1QrY2ZtdWoxeldveldQVUxsRDRyTiYjeEE7SVAxSEJ3UjdralVaQi9GTDVsUHRFL01yelBwMHlldGNHL3RnUnpodUR5WWoyaysyRDlPVnp3UlBrNWVEdFhOQTduaUhuK3Q3UG8rciYjeEE7V21yYWJCcUZvU1lKMXFBZXFrR2pLM3VEdG1ES0pCb3ZVNGMwY2tCS1BJb3drS0NTYUFia25vQmtXMTRaNTE4OWFocmQ3TmIyOHpSYSYjeEE7U2pGWW9VSlgxRkczT1NuWGw0ZEJtd3hZUkViODNrdGYyaExMSWlKcUgzc1V5OTFqc1ZkaXJzVmRpcnNWZGlyc1ZhSUJCQkZRZGlEaSYjeEE7cUQwSHk3YlFlZnZMZW8yYUNNRFVyWVhFYTdMOFVxZ01CMjMyT09TWG9JOG5iZG01eWNnaVgxWG1vZXFRbW82cmFXRVlhZGp5YjdFYSYjeEE7N3NjVlNHWHpsTVQrNnRsVWY1YkVuOEtZcXMveGhmZjc0aS80Yit1S3UveGhmZjc0aS80Yit1S3Uvd0FZWDMrK0l2OEFodjY0cTcvRyYjeEE7RjkvdmlML2h2NjRxaXJYemhFekJibUF4Zy90b2VRSHpCeFZrRVVzY3NheVJzSFJoVldIUWpGWG5IL09RL3dENUszVVArTTF0L3dBbiYjeEE7bHpKMG45NEhIMWY5Mlh5Tm0zZE83Rlh0RnpPOXhjU3p2dThyczdIM1kxT1lvRkIwVTVjVWllOVR3c0hZcTdGWFlxN0ZYWXE5Zy9KdSYjeEE7NFo5QXU0Q1NSRGNrcjdCMFhiN3htRHFSNm5xT3haWGlJN3BNcjgwVHRCNWIxU1ZUUjB0SmlwSFkrbWFINzhweGk1QjJPcWx3NHBFZiYjeEE7elQ5ejUwemFQRE94VjJLdXhWMkt1eFYyS3V4VjJLdXhWTXZMQ2h2TTJqZy84dDFzZnVtVTVESjlKOXpsYUkxbWgvV0Q2TXpWdmJNRCYjeEE7MXk1ZWZWYmhtTlFqR05SNEJEVEZVQmlsMkt1eFYyS3V4VjJLc3E4bjNMdEJQYnNhckd3WlA5bFd2NnNVTVgvNXlILzhsYnFIL0dhMiYjeEE7L3dDVHk1azZUKzhEajZ2KzdMNUd6YnVuZGlyN2gvNVY3NU4vNnRrZi9CU2Y4MVpvL0dsM3UwL2svQi9ORHY4QWxYdmszL3EyUi84QSYjeEE7QlNmODFZK05MdlgrVDhIODBPLzVWNzVOL3dDclpIL3dVbi9OV1BqUzcxL2svQi9ORHY4QWxYdmszL3EyUi84QUJTZjgxWStOTHZYKyYjeEE7VDhIODBPLzVWNzVOL3dDclpIL3dVbi9OV1BqUzcxL2svQi9ORHliOHd0TXNkTjh6M0ZwWXdpQzNSSXlzYWtrQXNnSjZrNW00SkV4cyYjeEE7dk45cDRvd3pFUkZDZ3h2TG5Ydld2eVkvNDVXby93REdkZjhBaUdZT3E1aDZic1QrN2w3MmZYbG5iM3RwTmFYS2VwYnpvWTVVcVJWVyYjeEE7RkNLcVFmdXpIQm8yN2ljQklHSjVGajMvQUNyUHlSLzFiZjhBa3ZjZjlWTXQ4ZWZlNFA4QUplbi9BSnYybjliditWWitTUDhBcTIvOCYjeEE7bDdqL0FLcVkrUFB2WCtTOVAvTiswL3JkL3dBcXo4a2Y5VzMvQUpMM0gvVlRIeDU5Ni95WHAvNXYybjlhUytjZklmbFRUdkxOL2UyZCYjeEE7ajZWekNpbU9UMVptb1M2am96a2RENFpQSG1rWkFFdU5yT3o4TU1VcFJqdUIzbjlieUxNNTVoWHNJa2x2cmFLUWNra2xSWEhTb0xBSCYjeEE7cGtaSFpzeFJCbUFlOFBjUCtWWitTUDhBcTIvOGw3ai9BS3FaZ2VQUHZlcy9rdlQvQU0zN1QrdDMvS3MvSkgvVnQvNUwzSC9WVEh4NSYjeEE7OTYveVhwLzV2Mm45YkQvek04bytYdEYwaTF1Tk10UHE4MGx3STNiMUpYcXZCalNqc3c2akxzR1NVanU2enRUUjRzV01HQW8zNXZPTSYjeEE7eTNSSnA1Vy81U2ZTUCtZMjMvNU9ya01uMG4zT1JwUDc2SDlZZmUraXMxYjNER2JqeWxjUzNFc291RUFrZG1Bb2RxbXVLcWYrRHJuLyYjeEE7QUphRSs0NHE3L0Ixei95MEo5eHhWMytEcm4vbG9UN2ppcnY4SFhQL0FDMEo5eHhWSzlWMHVUVHBraWR4SVhYa0NBUjNwM3hWQllwWiYjeEE7RjVOYjkvY3I0cXArNG4rdUtHUC9BUE9RL3dENUszVVArTTF0L3dBbmx6SjBuOTRISDFmOTJYeU5tM2RPN0ZYMFgveXN6enYvQU5YTCYjeEE7L2toYi93RFZQTUR3SWR6ci93Q1ZOUi9PK3dmcWQveXN6enYvQU5YTC9raGIvd0RWUEh3SWR5L3lwcVA1MzJEOVR2OEFsWm5uZi9xNSYjeEE7ZjhrTGYvcW5qNEVPNWY1VTFIODc3QitwMy9LelBPLy9BRmN2K1NGdi93QlU4ZkFoM0wvS21vL25mWVAxTy81V1o1My9BT3JsL3dBayYjeEE7TGY4QTZwNCtCRHVYK1ZOUi9PK3dmcVNQVmRXMURWYjFyMi9sOWE1Y0FOSnhWS2hSUWJJRkhUMnl5TVJFVUhFelpwWkpjVWpaUW1TYSYjeEE7bnJYNU1mOEFISzFIL2pPdi9FTXdkVnpEMDNZbjkzTDNzdDgzWGR6WitXdFJ1YmFReFR4UWxvNUY2Z2p2bE9NWElPeTFjekhGSWptQSYjeEE7OFcveDU1dy82dWszL0MvMHpQOEFCaDNQSy95am4vbkYzK1BQT0gvVjBtLzRYK21QZ3c3bC9sSFAvT0wxMzh2ZFJ2ZFE4cld0MWV6TiYjeEE7UGNPMG9hUnVwQ3lNQjA5aG1GbWlCS2c5SjJkbGxQQ0pTTm5mNzEzNWhmOEFLRzZuL3dBWTEvNU9MZ3cvVUdYYUg5eEwzUEFzMmJ4YSYjeEE7SjB2L0FJNmRwL3htai80bU1qTGtXM0IvZVI5NGZTdWFwN3QyS3NBL09YL2pnMlgvQURGRC9rMitaT2wrcDAzYmY5MFA2MzZDOGd6TyYjeEE7ZVlUVHl0L3lrK2tmOHh0di93QW5WeUdUNlQ3bkkwbjk5RCtzUHZmUldhdDdoaFY1cnVySmR6b2x3UXF5TXFpaTdBTVFPMktxUCtJTiYjeEE7WS81YVcrNWY2WXF5M1E3aWE0MHVDYVp1Y2pjdVRHbTlISUhUNVlxK1ZmTTM1eGZtWGFlWk5WdGJmWFpvN2VDOHVJb1l3a05GUkpXViYjeEE7UnVuWUROdkRUd01SczZuSnFaaVJGOVV5L0xiODJQekQxWHozb21uYWhyVXR4WlhOeXNjOExKRUF5a0hZa0lEa00yQ0FnU0F6d2FpYyYjeEE7cGdFdmV2T0grOTBIL0dML0FJMk9hdDJhUVlwWkQ1Ty8zcHVQOVFmcnhRa0gvT1EvL2tyZFEvNHpXMy9KNWN5ZEovZUJ4OVgvQUhaZiYjeEE7STJiZDA3c1ZleVpqUFB1eFYyS3V4VjJLdXhWMkt2V3Z5WS80NVdvLzhaMS80aG1EcXVZZW03RS91NWU5bEhubi9sRWRWLzR3Ti9ESyYjeEE7c1gxQno5ZC9jejl6NTl6WnZGT3hWN2wrVjMvS0dXZit2Ti95ZGJOZHFQckwxL1pYK0x4K1Azb3Y4d3YrVU4xUC9qR3YvSnhjamgrbyYjeEE7TnZhSDl4TDNQQXMyYnhhSjB2OEE0NmRwL3dBWm8vOEFpWXlNdVJiY0g5NUgzaDlLNXFudTNZcXdEODVmK09EWmY4eFEvd0NUYjVrNiYjeEE7WDZuVGR0LzNRL3Jmb0x5RE01NWhOUEszL0tUNlIvekcyLzhBeWRYSVpQcFB1Y2pTZjMwUDZ3Kzk5RlpxM3VIbmQvOEE3M1hIL0dWLyYjeEE7K0pIRktoaXJPUExmL0hGdHY5bi9BTW5HeFErSi9PSC9BQ2x1dC84QU1mZGY4bm16ZTQvcEh1ZEZsK3MrOU9QeWkvOEFKbCtYZitZeCYjeEE7UDFISWFqNkMyYWIrOEQ2bjg0ZjczUWY4WXY4QWpZNXBYY3BCaWxrUGs3L2VtNC8xQit2RkNRZjg1RC8rU3QxRC9qTmJmOG5sekowbiYjeEE7OTRISDFmOEFkbDhqWnQzVHV4VjdKbU04KzdGWHFlamZsTm9sOXBGamV5WGR5c2wxYnhUT3FtUGlHa1FNUUtyMDN6RGxxQ0NROUZnNyYjeEE7SHh6aEdSTXR3RDAvVWpQK1ZOYUQvd0F0dDE5OGYvTkdSL05TYmY1RXhkOHZzL1U3L2xUV2cvOEFMYmRmZkgvelJqK2FrdjhBSW1MdiYjeEE7bDluNm5uZm5MUXJiUTllbTA2M2tlV0tOVVlQSlRsOGFoajBBR1pPS1prTExwTmRweGh5Y0k1Skpscmh2V3Z5WS93Q09WcVAvQUJuWCYjeEE7L2lHWU9xNWg2YnNUKzdsNzJVZWVmK1VSMVgvakEzOE1xeGZVSFAxMzl6UDNQbjNObThVN0ZYdVg1WGY4b1paLzY4My9BQ2RiTmRxUCYjeEE7ckwxL1pYK0x4K1Azb3Y4QU1ML2xEZFQvQU9NYS93REp4Y2poK29OdmFIOXhMM1BBczJieGFKMHYvanAybi9HYVAvaVl5TXVSYmNIOSYjeEE7NUgzaDlLNXFudTNZcXdEODVmOEFqZzJYL01VUCtUYjVrNlg2blRkdC93QjBQNjM2Qzhnek9lWVRUeXQveWsra2Y4eHR2L3lkWElaUCYjeEE7cFB1Y2pTZjMwUDZ3Kzk5RlpxM3VIbmQvL3ZkY2Y4Wlgvd0NKSEZLaGlyT1BMZjhBeHhiYi9aLzhuR3hRK1JmTlhrTHoxUDVvMWlhSCYjeEE7eTVxa3NNdDdjdkhJbGxjTXJLMHJFTXBDVUlJNkhOekRMRGhHNGROa3hUTWpzZWFhL2xkNUk4NldYNWhhRGRYbWdhbGJXc04wclRUeiYjeEE7V2s4Y2FLQWQyWmtBQStlUno1WW1Cb2hucDhjaE1FZ3ZvenpoL3ZkQi93QVl2K05qbW9kc2tHS1dRK1R2OTZiai9VSDY4VUpCL3dBNSYjeEE7RC84QWtyZFEvd0NNMXQveWVYTW5TZjNnY2ZWLzNaZkkyYmQwN3NWZXlaalBQdXhWOUYrVnYrVVkwai9tQ3QvK1RTNXE4bjFIM3ZjYSYjeEE7VCs1aC9WSDNKbmtISWRpcnc3ODAvd0RsTXJyL0FJeHcvd0RKc1pzTlA5THlmYS85K2ZjR0paZTZ0NjErVEgvSEsxSC9BSXpyL3dBUSYjeEE7ekIxWE1QVGRpZjNjdmV5anp6L3lpT3EvOFlHL2hsV0w2ZzUrdS91Wis1OCs1czNpbllxOXkvSzcvbERMUC9YbS93Q1RyWnJ0UjlaZSYjeEE7djdLL3hlUHgrOUYvbUYveWh1cC84WTEvNU9Ma2NQMUJ0N1EvdUplNTRGbXplTFJPbC84QUhUdFArTTBmL0V4a1pjaTI0UDd5UHZENiYjeEE7VnpWUGR1eFZnSDV5L3dESEJzditZb2Y4bTN6SjB2MU9tN2IvQUxvZjF2MEY1Qm1jOHdtbmxiL2xKOUkvNWpiZi9rNnVReWZTZmM1RyYjeEE7ay92b2YxaDk3Nkt6VnZjUE83Ly9BSHV1UCtNci93REVqaWxReFZsbWg2eHB0dnBjRU0wNFNSZVhKU0cycTVJNkQzeFFqLzhBRUdqLyYjeEE7QVBMU3YzTi9URlhmNGcwZi9scFg3bS9waXJIUE0xN2EzZDNFOXZJSkZXT2hJQkc5U2UrS3BQaWxrUGszL2VtNS93QlJmMTRvU0QvbiYjeEE7SWY4QThsYnFIL0dhMi81UExtVHBQN3dPUHEvN3N2a2JOdTZkMkt2Wk14bm4zWXEraS9LMy9LTWFSL3pCVy84QXlhWE5YaytvKzk3aiYjeEE7U2YzTVA2bys1TThnNURzVmVIZm1uL3ltVjEveGpoLzVOak5ocC9wZVQ3WC9BTDgrNE1TeTkxYjFyOG1QK09WcVAvR2RmK0laZzZybSYjeEE7SHB1eFA3dVh2WlI1NS81UkhWZitNRGZ3eXJGOVFjL1hmM00vYytmYzJieFRzVmU1ZmxkL3lobG4vcnpmOG5XelhhajZ5OWYyVi9pOCYjeEE7Zmo5N0l0VjB5MTFUVDVyQzZCTnZPQXNnVThUUUVIWS9SbFVaVWJEbTVjWW5FeFBJc1gvNVZQNVEvd0I5ei84QUkwLzB5Nzh4SndQNSYjeEE7SXdkeCthK0g4clBLY00wY3lKTnpqWU90WlQxVTFIYkFkUkpsSHNyQ0RZQjI4Mlg1UzdGMktzQS9PWC9qZzJYL0FERkQvazIrWk9sKyYjeEE7cDAzYmY5MFA2MzZDOGd6T2VZV3ZxZHpwU05xbHJ4TnpZQTNNSE1WWDFJZmpYa05xaXE3NE9HOW03Qktza1Q1aEMvOEFReS81ai95VyYjeEE7SC9JaC93RHFwZy9KdzgzcGZ6cy9KNmZvR3J5YXpvbGpxc3BVejNzS1RUK21LS0pYRlpBb0pOQUhxT3VhM0pIaGtRN1BITGlpQ21HUSYjeEE7WnV4VjJLdXhWMkt1eFZrdmt4R3JkUDhBcy9BdjA3bkZESFArY2gvL0FDVnVvZjhBR2EyLzVQTG1UcFA3d09QcS93QzdMNUd6YnVuZCYjeEE7aXIyVE1aNTkyS3Zvdnl0L3lqR2tmOHdWdi95YVhOWGsrbys5N2pTZjNNUDZvKzVNOGc1RHNWZUhmbW4vQU1wbGRmOEFHT0gvQUpOaiYjeEE7TmhwL3BlVDdYL3Z6N2d4TEwzVnZXdnlZL3dDT1ZxUC9BQm5YL2lHWU9xNWg2YnNUKzdsNzJVZWVmK1VSMVgvakEzOE1xeGZVSFAxMyYjeEE7OXpQM1BuM05tOFU3Rlh1WDVYZjhvWlovNjgzL0FDZGJOZHFQckwxL1pYK0x4K1Azc3N5bDJMc1ZkaXJzVmRpckFQemwvd0NPRFpmOCYjeEE7eFEvNU52bVRwZnFkTjIzL0FIUS9yZm9MeURNNTVoQmExL3h4Ny84QTVoNWYrSUhESG0yWXZySHZEeXVPR2FVa1JJemtkUW9KL1ZtUiYjeEE7YnZRQ1hwdjVaZWZaOUdnWFJkV3RwMnNTNU5yT2tidTBSYzFLRkZCWXFXTlJUZXY0WU9wMC9FZUljM1AwMll4SERJR25yMXRxVmhjbyYjeEE7SGhtVWc5ajhMZlNyVVlmZG12TUNPam5naEVqNGdDdTRQUWpCU1Z5UXl2WGdqTlRyUUUvcXdLditxM1ArK1gvNEU0cGQ5VnV2OTh2LyYjeEE7QU1DZjZZcWlyVFE5VXVYNHJBMGE5M2tCUmZ4Ni9SaWhtT2w2ZEZZV2l3SWVScnlrZnB5WTk4VllEL3prUC81SzNVUCtNMXQveWVYTSYjeEE7blNmM2djZlYvd0IyWHlObTNkTzdGWDNOL2dieWovMWFvUDhBZ2Y3YzBmaXk3M2Eva2NQOHdPL3dONVIvNnRVSC9BLzI0K0xMdlg4aiYjeEE7aC9tQk9ZSUliZUNPQ0ZCSERDcXh4SU9pcW9vb0h5R1ZrMjVVWWdDaHlDL0ZMc1ZTdS84QUszbDdVTGxycTlzSXA3aGdBMGppcElBbyYjeEE7TW1Na2h5TFJrMHVPWnVVUVNoLzhEZVVmK3JWQi93QUQvYmg4V1hlMS9rY1A4d0pocG1qYVhwY2J4NmZiSmJKSWVUckdLQWtDbGNqSyYjeEE7UlBOdnhZWVl4VVJTdmRXdHZkMjhsdGN4aVdDVWNaSTI2RWVCd0EweWxFU0ZIa2xIK0J2S1AvVnFnLzRIKzNKK0xMdmNiOGpoL21CMyYjeEE7K0J2S1AvVnFnLzRIKzNIeFpkNi9rY1A4d0pwWWFmWmFmYkxhMlVLd1c2RWxZazJBTEdwL0hJRWs4M0l4NDR3RlJGQmpYNXNhenFXaiYjeEE7Zmw3ckdwNlpPYmErdGtqTUU2aFNWTFRJcDJZRWRHSXkzQkVTbUFXT2FSRUNRK1l2K1YyZm1sLzFNRTMvQUNMaC93Q3FlYlA4dGo3biYjeEE7Vi9tc25laXRLL09mOHpwdFRzNHBOZW1hT1NlTkhYMDRkMVp3Q1BzWUphZUZjbWNOVGtNZ0xmWUdhZDJ6c1ZlVy93RE9RdXRmb2p5ciYjeEE7cDl6NlByODc1WStITGhTc01ocldqZnk1bDZPTnlQdWRaMnBoOFRHQmRiL3JlQS84ckUvN1YvOEF5Vy81c3pZZUc2TDhqNS9ZbnZrUCYjeEE7enY4QVh2TzJnMm4xTDAvV3Y3WmVmcThxZnZWN2NCbGVXRlFQdWI5Tm9xeXhOOGlPajZ6elVQVXV4VjJLdXhWMkt1eFYyS3V4VjJLbyYjeEE7VFZ0SDB2VjdKN0hWTFdPOHM1Q0M4RXloMEpVMVVrSHdPR01pRFlRWWdpaWtQL0tyUHk0LzZseXcvd0NSQ2YweXp4NTk1WWVERHVEdiYjeEE7K1ZXZmx4LzFMbGgveUlUK21Qano3eXZndzdneW5LbXgyS3V4VjJLdXhWMkt1eFYyS3V4VjJLdXhWMktzQi9QZ2tmbFByMVA1YmI4YiYjeEE7dUhNalMvM2dhTlQvQUhaZkhlYmgweVAwRkMrdWFjZzZ0Y3dnZlRJTWpQa1dlUDZoNzMzbm1oZDY3RlhqWC9PVW4vS0U2Wi8yMGsvNSYjeEE7TVRabTZINmo3bkQxMzBEM3ZtTE5tNnRrL3dDV0gva3hmTGYvQUcwYmIvazRNcXovQUVIM04ybitzUHR2Tkk3cDJLdXhWMkt1eFYySyYjeEE7dXhWMkt1eFYyS3V4VjJLdXhWMkt1eFYyS3V4VjJLdXhWMkt1eFYyS3V4VjJLc0YvUEdCcHZ5cjE5RkZTSTRYMjhJN2lOei94SEw5TSYjeEE7ZjNnYWRRTHhsOGI1dVhTcjRaWklaVW1pYmpKR3dkR0hVTXBxRGlvTlB1dnl2NWdzdk1QbCt3MXF6WUdDK2hXVGlEWGczUjR6N280SyYjeEE7bjVab1p3TVNRWGZRa0pDd21tUlpQblgvQUp5ZjgzMmwxZGFkNVh0WkJJOWt4dTcraHFGa1plTVNmNndSbUorWXpZNkxIVnlkZnJjZyYjeEE7Mmk4SHpQZGV5bjhyVWQvekc4dGhSVWpVSUdwN0s0Si9BWlZuK2crNXUwLzFoOXM1cEhkT3hWMkt1eFYyS3V4VjJLdXhWMkt1eFYySyYjeEE7dXhWMkt1eFYyS3V4VjJLdXhWMkt1eFYyS3V4VjJLdXhWTC9NT2tSNnpvT282VElRcVg5dExiRmp2eDlWQ29iNksxeVVKY0pCWXlqWSYjeEE7SWZDdC9ZM1ZoZlhGamR4bUs2dFpIaG5qYnFyeHNWWUg1RVp2UWJGaDBVb2tHaWg4S0daZVFmelY4MStTV2tqMHlSSjlQbWJuTnA5eSYjeEE7QzBSYnB6WGlWWkdwM0IzMnFEUVpUbHdSbno1dCtMVVNoeTVNbDh5Zjg1SWVlOVZ0M3R0UFMzMGVKeFJwYmNNODlDS0VDU1FrTDgxVSYjeEE7RWVPVlEwY0J6M2JaNjJSNWJQSzVaWlpwWGxtZHBKWkNXa2tjbG1aanVTU2R5VG1XNFpOck1WZXQvd0RPTnZsZVhVdk83YXk2bjZwbyYjeEE7c1RQekkyTTg2bU9OZitCTE45QXpFMWs2alhlNW1peDNLKzU5VDVxbmFPeFYyS3V4VjJLdXhWMkt1eFYyS3V4VjJLdXhWMkt1eFYySyYjeEE7dXhWMkt1eFYyS3V4VjJLdXhWMkt1eFYyS3ZDUCtjZ1B5a3VMOTM4M2FCYnRMZEJRTldzNGxxenFvb0xoRkc1WUFVY0R0djQ1bjZUVSYjeEE7VjZTNE9xMDkrb2MzenBteGRhN0ZYWXE3RlU1OHFlVWRkODFhdkhwV2pXNW11SDNrYzdSeEoza2tmOWxSK1BRVk9ReVpCQVdXZVBHWiYjeEE7bWcreVBJZmtyVFBKM2wyRFJySDk0VnJKZFhKRkdtbVlEazVHOU9sQU93elRaY2huS3k3bkhqRUJRWkRsYlk3RlhZcTdGWFlxN0ZYWSYjeEE7cTdGWFlxN0ZYWXE3RlhZcTdGWFlxN0ZYWXE3RlhZcTdGWFlxN0ZYWXE3RlhZcTdGWGwvbi93RElIeXI1bm1sMURUMk9qYXRLUzBrcyYjeEE7S2hvSldQVXlRMVdqSCtaU1BFZ25NckZxcFIyTzRjYkxwWXozNUY0L3EzL09PSDVsV2NoRnBEYmFtbjdMMjg2Um1udUxqMGFabVIxayYjeEE7RHoyY09Xam1PVzZYeC9rRitiRE9GT2lCQjBMTmRXbEI5MHBPUy9OWSs5Z05KazdtWmVXUCtjWGRYbWtTWHpMcWNWcEJzV3RyS3NzeCYjeEE7MzNVeU9GUkQ3Z05sTTlhUDRRM3cwUDhBT0wzYnl0NVE4dmVWdE9HbjZKWnBhdzdHVnh2Skl3L2FrYy9FeCtmVHRtQlBJWkd5NTBJQyYjeEE7SW9KeGtHYnNWZGlyc1ZkaXJzVmRpcnNWZGlyc1ZkaXJzVmRpci8vWjwveG1wR0ltZzppbWFnZT4KICAgICAgICAgICAgICAgPC9yZGY6bGk+CiAgICAgICAgICAgIDwvcmRmOkFsdD4KICAgICAgICAgPC94bXA6VGh1bWJuYWlscz4KICAgICAgICAgPHhtcE1NOkluc3RhbmNlSUQ+eG1wLmlpZDowZjgyMWIxOC02YmU5LTk0NDYtOTdjNS1hYjZlNzVjZWRkMTc8L3htcE1NOkluc3RhbmNlSUQ+CiAgICAgICAgIDx4bXBNTTpEb2N1bWVudElEPnhtcC5kaWQ6MGY4MjFiMTgtNmJlOS05NDQ2LTk3YzUtYWI2ZTc1Y2VkZDE3PC94bXBNTTpEb2N1bWVudElEPgogICAgICAgICA8eG1wTU06T3JpZ2luYWxEb2N1bWVudElEPnV1aWQ6NUQyMDg5MjQ5M0JGREIxMTkxNEE4NTkwRDMxNTA4Qzg8L3htcE1NOk9yaWdpbmFsRG9jdW1lbnRJRD4KICAgICAgICAgPHhtcE1NOlJlbmRpdGlvbkNsYXNzPnByb29mOnBkZjwveG1wTU06UmVuZGl0aW9uQ2xhc3M+CiAgICAgICAgIDx4bXBNTTpEZXJpdmVkRnJvbSByZGY6cGFyc2VUeXBlPSJSZXNvdXJjZSI+CiAgICAgICAgICAgIDxzdFJlZjppbnN0YW5jZUlEPnhtcC5paWQ6MDhhNGVkYTQtODNkYS00NjQyLTlmOGUtNTVlZjBlMzVkMzhmPC9zdFJlZjppbnN0YW5jZUlEPgogICAgICAgICAgICA8c3RSZWY6ZG9jdW1lbnRJRD54bXAuZGlkOjA4YTRlZGE0LTgzZGEtNDY0Mi05ZjhlLTU1ZWYwZTM1ZDM4Zjwvc3RSZWY6ZG9jdW1lbnRJRD4KICAgICAgICAgICAgPHN0UmVmOm9yaWdpbmFsRG9jdW1lbnRJRD51dWlkOjVEMjA4OTI0OTNCRkRCMTE5MTRBODU5MEQzMTUwOEM4PC9zdFJlZjpvcmlnaW5hbERvY3VtZW50SUQ+CiAgICAgICAgICAgIDxzdFJlZjpyZW5kaXRpb25DbGFzcz5wcm9vZjpwZGY8L3N0UmVmOnJlbmRpdGlvbkNsYXNzPgogICAgICAgICA8L3htcE1NOkRlcml2ZWRGcm9tPgogICAgICAgICA8eG1wTU06SGlzdG9yeT4KICAgICAgICAgICAgPHJkZjpTZXE+CiAgICAgICAgICAgICAgIDxyZGY6bGkgcmRmOnBhcnNlVHlwZT0iUmVzb3VyY2UiPgogICAgICAgICAgICAgICAgICA8c3RFdnQ6YWN0aW9uPnNhdmVkPC9zdEV2dDphY3Rpb24+CiAgICAgICAgICAgICAgICAgIDxzdEV2dDppbnN0YW5jZUlEPnhtcC5paWQ6ODhENTIxQkM2MjkxRTMxMTgxRjFGQ0E1OTYyRDU1QTE8L3N0RXZ0Omluc3RhbmNlSUQ+CiAgICAgICAgICAgICAgICAgIDxzdEV2dDp3aGVuPjIwMTQtMDItMDlUMTE6Mjc6MTgrMDM6MDA8L3N0RXZ0OndoZW4+CiAgICAgICAgICAgICAgICAgIDxzdEV2dDpzb2Z0d2FyZUFnZW50PkFkb2JlIElsbHVzdHJhdG9yIENTNiAoV2luZG93cyk8L3N0RXZ0OnNvZnR3YXJlQWdlbnQ+CiAgICAgICAgICAgICAgICAgIDxzdEV2dDpjaGFuZ2VkPi88L3N0RXZ0OmNoYW5nZWQ+CiAgICAgICAgICAgICAgIDwvcmRmOmxpPgogICAgICAgICAgICAgICA8cmRmOmxpIHJkZjpwYXJzZVR5cGU9IlJlc291cmNlIj4KICAgICAgICAgICAgICAgICAgPHN0RXZ0OmFjdGlvbj5zYXZlZDwvc3RFdnQ6YWN0aW9uPgogICAgICAgICAgICAgICAgICA8c3RFdnQ6aW5zdGFuY2VJRD54bXAuaWlkOjBmODIxYjE4LTZiZTktOTQ0Ni05N2M1LWFiNmU3NWNlZGQxNzwvc3RFdnQ6aW5zdGFuY2VJRD4KICAgICAgICAgICAgICAgICAgPHN0RXZ0OndoZW4+MjAxNC0wOS0yMlQxNDo0ODoxNSswMzowMDwvc3RFdnQ6d2hlbj4KICAgICAgICAgICAgICAgICAgPHN0RXZ0OnNvZnR3YXJlQWdlbnQ+QWRvYmUgSWxsdXN0cmF0b3IgQ0MgKFdpbmRvd3MpPC9zdEV2dDpzb2Z0d2FyZUFnZW50PgogICAgICAgICAgICAgICAgICA8c3RFdnQ6Y2hhbmdlZD4vPC9zdEV2dDpjaGFuZ2VkPgogICAgICAgICAgICAgICA8L3JkZjpsaT4KICAgICAgICAgICAgPC9yZGY6U2VxPgogICAgICAgICA8L3htcE1NOkhpc3Rvcnk+CiAgICAgICAgIDxpbGx1c3RyYXRvcjpTdGFydHVwUHJvZmlsZT5QcmludDwvaWxsdXN0cmF0b3I6U3RhcnR1cFByb2ZpbGU+CiAgICAgICAgIDxwZGY6UHJvZHVjZXI+QWRvYmUgUERGIGxpYnJhcnkgMTAuMDE8L3BkZjpQcm9kdWNlcj4KICAgICAgPC9yZGY6RGVzY3JpcHRpb24+CiAgIDwvcmRmOlJERj4KPC94OnhtcG1ldGE+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAKPD94cGFja2V0IGVuZD0idyI/Pv/bAEMAAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAgIBAQIBAQECAgICAgICAgIBAgICAgICAgICAv/bAEMBAQEBAQEBAQEBAQIBAQECAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAv/AABEIAfUC4QMBEQACEQEDEQH/xAAfAAEAAgMBAQEBAQEAAAAAAAAACQoHCAsGBQQC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",
          });
        },
      },
      csvHtml5: {
        text: "<i class='fa fa-file-csv'></i>",
      },
    };

    const tableObj = ref({
      dom: "Bfrtip",
      buttons: setButtons(),
    });

    onBeforeMount(() => {
      if (props.hasOwnProperty("extraOptions")) {
        tableObj.value = Object.assign(tableObj.value, props.extraOptions);
      }
      if (props.isLarge) {
        tableObj.value.buttons[2] = {
          ...tableObj.value.buttons[2],
          orientation: "landscape",
          pageSize: "LEGAL",
        };
      }
    });

    function setButtons() {
      return Object.keys(buttons).map((key) => {
        const obj = {
          ...buttons[key],
          extend: key,
          title: pluralize(props.entity, true),
          exportOptions: {
            columns: props.columns,
          },
        };
        if (buttons[key].hasOwnProperty("format")) {
          obj.exportOptions["format"] = buttons[key].format;
        }
        if (buttons[key].hasOwnProperty("customize")) {
          obj["customize"] = buttons[key].customize;
        }
        return obj;
      });
    }

    function ucwords(str) {
      return str.toLowerCase().replace(/\b[a-z]/g, (letter) => letter.toUpperCase());
    }

    function pluralize(str, capital = false) {
      if (/y$/.test(str)) {
        str = str.replace(/y$/, "ies");
      } else {
        str += "s";
      }
      return capital ? ucwords(str) : str;
    }

    watch(
      () => [props.objects, selectedZone],
      (_) => {
        $("#datatable").DataTable().destroy();
        nextTick(() => {
          if (props.objects.length > 0) {
            $("#datatable").DataTable({ ...tableObj.value });
          } else {
            $("#datatable")
              .DataTable({
                bDestroy: true,
              })
              .clear()
              .draw();
          }
        });
      },
      {
        deep: true,
      }
    );

    return {
      zones,
      selectedZone,
      setZone,
      entity: computed(() => props.entity),
      ucwords,
      pluralize,
      isFetching: computed(() => props.fetching),
      canStore: computed(() => attrs.hasOwnProperty("onCreateEntity")),
    };
  },
};
</script>
