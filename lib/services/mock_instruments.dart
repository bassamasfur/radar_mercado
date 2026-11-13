import '../models/market_instrument.dart';

const mockInstruments = <String, List<MarketInstrument>>{
  'tech': [
    MarketInstrument(
      name: 'NVIDIA',
      symbol: 'NVDA',
      type: InstrumentType.stock,
      day: 3.20,
    ),
    MarketInstrument(
      name: 'Microsoft',
      symbol: 'MSFT',
      type: InstrumentType.stock,
      day: 1.80,
    ),
    MarketInstrument(
      name: 'Apple',
      symbol: 'AAPL',
      type: InstrumentType.stock,
      day: 0.90,
    ),
  ],
  'comm': [
    MarketInstrument(
      name: 'Meta',
      symbol: 'META',
      type: InstrumentType.stock,
      day: 1.70,
    ),
    MarketInstrument(
      name: 'Alphabet',
      symbol: 'GOOGL',
      type: InstrumentType.stock,
      day: 1.10,
    ),
    MarketInstrument(
      name: 'Netflix',
      symbol: 'NFLX',
      type: InstrumentType.stock,
      day: 0.40,
    ),
  ],
  'disc': [
    MarketInstrument(
      name: 'Amazon',
      symbol: 'AMZN',
      type: InstrumentType.stock,
      day: 1.20,
    ),
    MarketInstrument(
      name: 'Home Depot',
      symbol: 'HD',
      type: InstrumentType.stock,
      day: 0.60,
    ),
    MarketInstrument(
      name: 'Nike',
      symbol: 'NKE',
      type: InstrumentType.stock,
      day: -0.30,
    ),
  ],
  'health': [
    MarketInstrument(
      name: 'Eli Lilly',
      symbol: 'LLY',
      type: InstrumentType.stock,
      day: 1.10,
    ),
    MarketInstrument(
      name: 'Johnson & Johnson',
      symbol: 'JNJ',
      type: InstrumentType.stock,
      day: 0.30,
    ),
    MarketInstrument(
      name: 'Pfizer',
      symbol: 'PFE',
      type: InstrumentType.stock,
      day: -0.20,
    ),
  ],
  'staples': [
    MarketInstrument(
      name: 'Coca-Cola',
      symbol: 'KO',
      type: InstrumentType.stock,
      day: 0.70,
    ),
    MarketInstrument(
      name: 'Procter & Gamble',
      symbol: 'PG',
      type: InstrumentType.stock,
      day: 0.20,
    ),
    MarketInstrument(
      name: 'PepsiCo',
      symbol: 'PEP',
      type: InstrumentType.stock,
      day: -0.40,
    ),
  ],
  'util': [
    MarketInstrument(
      name: 'NextEra Energy',
      symbol: 'NEE',
      type: InstrumentType.stock,
      day: 0.50,
    ),
    MarketInstrument(
      name: 'Duke Energy',
      symbol: 'DUK',
      type: InstrumentType.stock,
      day: -0.20,
    ),
    MarketInstrument(
      name: 'Southern Company',
      symbol: 'SO',
      type: InstrumentType.stock,
      day: -0.70,
    ),
  ],
  'fin': [
    MarketInstrument(
      name: 'JPMorgan Chase',
      symbol: 'JPM',
      type: InstrumentType.stock,
      day: 1.30,
    ),
    MarketInstrument(
      name: 'Visa',
      symbol: 'V',
      type: InstrumentType.stock,
      day: 0.90,
    ),
    MarketInstrument(
      name: 'Bank of America',
      symbol: 'BAC',
      type: InstrumentType.stock,
      day: 0.20,
    ),
  ],
  'ind': [
    MarketInstrument(
      name: 'Caterpillar',
      symbol: 'CAT',
      type: InstrumentType.stock,
      day: 1.50,
    ),
    MarketInstrument(
      name: 'Union Pacific',
      symbol: 'UNP',
      type: InstrumentType.stock,
      day: 0.80,
    ),
    MarketInstrument(
      name: 'Honeywell',
      symbol: 'HON',
      type: InstrumentType.stock,
      day: 0.10,
    ),
  ],
  'mat': [
    MarketInstrument(
      name: 'Newmont',
      symbol: 'NEM',
      type: InstrumentType.stock,
      day: 0.80,
    ),
    MarketInstrument(
      name: 'Freeport-McMoRan',
      symbol: 'FCX',
      type: InstrumentType.stock,
      day: -0.10,
    ),
    MarketInstrument(
      name: 'Dow',
      symbol: 'DOW',
      type: InstrumentType.stock,
      day: -0.60,
    ),
  ],
  'energy': [
    MarketInstrument(
      name: 'Exxon Mobil',
      symbol: 'XOM',
      type: InstrumentType.stock,
      day: 1.90,
    ),
    MarketInstrument(
      name: 'Chevron',
      symbol: 'CVX',
      type: InstrumentType.stock,
      day: 1.10,
    ),
    MarketInstrument(
      name: 'ConocoPhillips',
      symbol: 'COP',
      type: InstrumentType.stock,
      day: 0.50,
    ),
  ],
  'defense': [
    MarketInstrument(
      name: 'Lockheed Martin',
      symbol: 'LMT',
      type: InstrumentType.stock,
      day: 1.40,
    ),
    MarketInstrument(
      name: 'RTX',
      symbol: 'RTX',
      type: InstrumentType.stock,
      day: 0.80,
    ),
    MarketInstrument(
      name: 'Northrop Grumman',
      symbol: 'NOC',
      type: InstrumentType.stock,
      day: 0.30,
    ),
  ],
  'reit': [
    MarketInstrument(
      name: 'Prologis',
      symbol: 'PLD',
      type: InstrumentType.stock,
      day: 0.40,
    ),
    MarketInstrument(
      name: 'Realty Income',
      symbol: 'O',
      type: InstrumentType.stock,
      day: -0.30,
    ),
    MarketInstrument(
      name: 'Simon Property Group',
      symbol: 'SPG',
      type: InstrumentType.stock,
      day: -0.90,
    ),
  ],
  'commodities': [
    MarketInstrument(
      name: 'Plata',
      symbol: 'SLV',
      type: InstrumentType.etf,
      day: 0.80,
      description: 'Metal precioso que también se usa en la industria.',
    ),
    MarketInstrument(
      name: 'Cobre',
      symbol: 'CPER',
      type: InstrumentType.etf,
      day: 0.25,
      description:
          'Metal industrial usado en construcción y electricidad. CPER utiliza contratos de futuros de cobre.',
    ),
    MarketInstrument(
      name: 'Oro',
      symbol: 'GLDM',
      type: InstrumentType.etf,
      day: -0.35,
      description: 'Metal precioso usado en joyería y como reserva de valor.',
    ),
  ],
  'btc': [
    MarketInstrument(
      name: 'iShares Bitcoin Trust',
      symbol: 'IBIT',
      type: InstrumentType.etf,
      day: 1.90,
    ),
    MarketInstrument(
      name: 'Fidelity Wise Origin Bitcoin Fund',
      symbol: 'FBTC',
      type: InstrumentType.etf,
      day: 1.80,
    ),
    MarketInstrument(
      name: 'Bitwise Bitcoin ETF',
      symbol: 'BITB',
      type: InstrumentType.etf,
      day: 1.70,
    ),
  ],
  'intl': [
    MarketInstrument(
      name: 'Vanguard Total International Stock ETF',
      symbol: 'VXUS',
      type: InstrumentType.etf,
      day: 0.25,
    ),
    MarketInstrument(
      name: 'iShares Core MSCI EAFE ETF',
      symbol: 'IEFA',
      type: InstrumentType.etf,
      day: 0.50,
    ),
    MarketInstrument(
      name: 'Vanguard FTSE Developed Markets ETF',
      symbol: 'VEA',
      type: InstrumentType.etf,
      day: 0.20,
    ),
  ],
  'em': [
    MarketInstrument(
      name: 'Vanguard FTSE Emerging Markets ETF',
      symbol: 'VWO',
      type: InstrumentType.etf,
      day: -0.15,
    ),
    MarketInstrument(
      name: 'iShares Core MSCI Emerging Markets ETF',
      symbol: 'IEMG',
      type: InstrumentType.etf,
      day: 0.30,
    ),
    MarketInstrument(
      name: 'iShares MSCI Emerging Markets ETF',
      symbol: 'EEM',
      type: InstrumentType.etf,
      day: -0.10,
    ),
  ],
};
