  function switchTab(tabId) {
    document.querySelectorAll('.tab').forEach(tab => tab.classList.remove('active'));
    document.getElementById(tabId).classList.add('active');
  }

  
	function ahkButtonClick(ele) {
		ahk.ButtonClick.Func(ele);
	}
	function ahkSave(ele) {
		ahk.Save.Func(ele);
	}





  function onSaveClick() {
    const cfg = {
      url:                 document.getElementById('url').value,
      discordID:           document.getElementById('discordID').value,
      VipLink:             document.getElementById('vipLink').value,
      VoidChest:          +document.getElementById('VoidChest').checked,
      InfinityChest:      +document.getElementById('InfinityChest').checked,
      GiantChest:         +document.getElementById('GiantChest').checked,
      DiceMerchant:       +document.getElementById('DiceMerchant').checked,
      Presents:           +document.getElementById('Presents').checked,
      AlienShop:          +document.getElementById('AlienShop').checked,
      TicketChest:        +document.getElementById('TicketChest').checked,
      BlackMarket:        +document.getElementById('BlackMarket').checked,
      TravelingMerchant:  +document.getElementById('TravelingMerchant').checked,
      GemGenie:           +document.getElementById('GemGenie').checked,
      RerollGemGenie:     +document.getElementById('RerollGemGenie').checked,
      SeasonQuests:       +document.getElementById('SeasonQuests').checked,
      Reroll:              document.querySelector('input[name="shops"]:checked').value,
      Macro:               document.querySelector('input[name="macro"]:checked').value,
      InfinityElixer:     +document.getElementById('InfinityElixer').checked,
      BlowBubbles:        +document.getElementById('BlowBubbles').checked,
      Teams:              +document.getElementById('Teams').checked,
      Premiumperk:        +document.getElementById('Premiumperk').checked
    };
    if (document.getElementById('Competitive').checked){
      cfg.Macro = "Competitive"
    }

    if (cfg.Macro == "dropdownSelect"){
      cfg.Macro = document.querySelector("#hiddenSelector").value
    }


    ahkSave(JSON.stringify(cfg))
	  console.log(cfg)
  }
  

  
  function applySettings(a) {
    const s = a.data
    console.log(s)
    document.getElementById('url').value       = s.url;
    document.getElementById('discordID').value = s.discordID;
    document.getElementById('vipLink').value   = s.VipLink;
    document.getElementById('GiantChest').checked  = !!+s.GiantChest;
    document.getElementById('VoidChest').checked    = !!+s.VoidChest;
    document.getElementById('InfinityChest').checked    = !!+s.InfinityChest;
    document.getElementById('TicketChest').checked  = !!+s.TicketChest;
    document.getElementById('DiceMerchant').checked = !!+s.DiceMerchant;
    document.getElementById('AlienShop').checked    = !!+s.AlienShop;
    document.getElementById('BlackMarket').checked  = !!+s.BlackMarket;
    document.getElementById('TravelingMerchant').checked  = !!+s.TravelingMerchant;
    document.getElementById('GemGenie').checked  = !!+s.GemGenie;
    document.getElementById('RerollGemGenie').checked  = !!+s.RerollGemGenie;
    document.getElementById('SeasonQuests').checked  = !!+s.SeasonQuests;
    document.getElementById('Presents').checked     = !!+s.Presents;
    document.getElementById('BlowBubbles').checked    = !!+s.BlowBubbles;
    document.getElementById('Teams').checked    = !!+s.Teams;
    document.getElementById('Premiumperk').checked    = !!+s.Premiumperk;
    document.getElementById('InfinityElixer').checked = !!+s.InfinityElixer;

    const mac = s.Macro || 'CoinCurrency';
    const r = document.querySelector(`input[name="macro"][value="${mac}"]`);
    if (r) r.checked = true;
    // if PickEgg, also set dropdown
    if (!(mac == 'TicketCurrency' || mac == 'CoinCurrency' || mac == "Competitive" || mac == "RealInfinity" || mac == "HyperDart")) {
      selectDropdownValueByData(mac)
      if (mac == "Twilight" || mac == "RobotFactory"){  
        document.getElementById('pickBubbleRadio').checked = true
      } else {
        document.getElementById('pickEggRadio').checked = true
      }

    } else if (mac == "Competitive"){
      document.getElementById("Competitive").checked = true
    }


    const reroll = s.Reroll
    const rerollelement = document.querySelector(`input[name="shops"][value="${reroll}"]`);
    if (rerollelement) rerollelement.checked = true;

}







document.querySelectorAll('.tabs button').forEach(button => {
  button.addEventListener('click', function() {
    document.querySelectorAll('.tabs button').forEach(btn => {
      btn.classList.remove('tab-button-active');
    });
    this.classList.add('tab-button-active');
  });
});

// Set first tab as active by default on load
document.addEventListener('DOMContentLoaded', function() {
  document.querySelector('.tabs button').classList.add('tab-button-active');
});