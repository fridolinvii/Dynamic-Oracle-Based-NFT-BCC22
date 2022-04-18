// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/Strings.sol";
import "./players.sol";



contract PlayerDetail {
    struct playerDetail {
      // Informations for the NFT
      uint gameplay;
      uint numberOfGames;
      uint goals;
      uint level;
      uint saves;
      uint assist;
      string position;
      string playersName;
    }
  }

contract getPlayerSvg is PlayerDetail {

  using Strings for uint; // Allows to convert uints to strings

  AndyPelmard andyPelmard;
  LiamMillar liamMillar;
  NoahKatterbach noahKatterbach;
  PajtimKasami pajtimKasami;
  HeinzLindner heinzLindner;






  constructor(address _AndyPelmard, address _LiamMillar, address _NoahKatterbach, address _PajtimKasami, address _HeinzLindner) {
      andyPelmard = AndyPelmard(_AndyPelmard); // 0x6d69e58B136AE0c18f5ffF6d96D4e8Db74cf76a3
      liamMillar = LiamMillar(_LiamMillar); // 0x6aa24b13A93ba61dd5675824f2b9e48bd5836bd3
      noahKatterbach = NoahKatterbach(_NoahKatterbach); // 0x9692501c9F4B4EC92Ee0ed2C9130fb90508e17E9
      pajtimKasami = PajtimKasami(_PajtimKasami); // 0x0Af2F3750c3741f575e18c47B86BA852dd7A667f
      heinzLindner = HeinzLindner(_HeinzLindner); // 0xe115Cd70906EBd92aaA7b5249B8714BEA370e953
  }





  function getSVG(playerDetail calldata _details,  uint level, uint tokenId, uint score) external view  returns (string memory svg) {

    uint gameplay = _details.gameplay;
    uint numberOfGames = _details.numberOfGames;
    uint goals = _details.goals;
    string memory name = _details.playersName;
    string memory position = _details.position;
    uint assist = _details.assist;
    uint saves = _details.saves;

    svg = '<svg width="390" height="435" fill="green" xmlns="http://www.w3.org/2000/svg">';
    svg = string(abi.encodePacked(svg,
        '<style>',
        'text { font-family: Arial, Helvetica, sans-serif; font-weight:  bold; fill: #ffe500; font-size: 1em; }',
        '.title { text-anchor: left; font-weight: bold; font-size: 1.5em; }',
        '</style>'
    ));
    svg = string(abi.encodePacked(svg, '<rect width="100%" height="100%" fill="', "#e40227" ,'" />'));

    svg = addImage(svg, name, level);

    svg = string(abi.encodePacked(svg, '<text x="80" y="40" class="title">', name ,'</text>'));
    svg = string(abi.encodePacked(svg, '<text x="20" y="320" >Position: ', position, '</text>'));
    svg = string(abi.encodePacked(svg, '<text x="20" y="340" >Gameplay: ', Strings.toString(gameplay), 'min', '</text>'));
    svg = string(abi.encodePacked(svg, '<text x="20" y="360" >Games: ', Strings.toString(numberOfGames),'</text>'));
    svg = string(abi.encodePacked(svg, '<text x="20" y="380" >Goals: ', Strings.toString(goals), '</text>'));
    // Goalkeeper has tokenid < 4
    if (keccak256(abi.encodePacked("Heinz Lindner"))==keccak256(abi.encodePacked(name))) {
      svg = string(abi.encodePacked(svg, '<text x="20" y="400" >Saves: ', Strings.toString(saves), '</text>'));
    } else {
      svg = string(abi.encodePacked(svg, '<text x="20" y="400" >Assist: ', Strings.toString(assist), '</text>'));
    }


    if (tokenId == 1001) { // Place 1!
      svg = string(abi.encodePacked(svg, '<text transform="translate(380,415) rotate(-90)" >Place 1 </text>'));
    }
    if (tokenId == 1002) { // Place 2!
      svg = string(abi.encodePacked(svg, '<text transform="translate(380,415) rotate(-90)" >Place 2 </text>'));
    }
    if (tokenId == 1003) { // Place 3!
      svg = string(abi.encodePacked(svg, '<text transform="translate(380,415) rotate(-90)" >Place 3 </text>'));
    }
    if (tokenId > 10000000) {
      svg = string(abi.encodePacked(svg, '<text transform="translate(380,415) rotate(-90)" >Team NFT </text>'));
    }
    if ( (tokenId>2000) && (tokenId<10000001) ) {
      svg = string(abi.encodePacked(svg, '<text transform="translate(380,415) rotate(-90)" >Score: ' , Strings.toString(score) , ' </text>'));
    }
    //svg = string(abi.encodePacked(svg, '<text x="20" y="80">NFT ID: ', tokenId.toString(), '</text>'));

    svg = string(abi.encodePacked(svg, '</svg>'));
  }





function addImage(string memory svg, string memory name, uint level) internal view returns (string memory _svg) {
  if (keccak256(abi.encodePacked("Noah Katterbach")) == keccak256(abi.encodePacked(name)) ) {
  //_svg = string(abi.encodePacked(svg, noahKatterbach.svg(level)));
     _svg = string(abi.encodePacked(svg, noahKatterbach.getSVG(level)));
}

if (keccak256(abi.encodePacked("Andy Pelmard")) == keccak256(abi.encodePacked(name)) ) {
  _svg = string(abi.encodePacked(svg, andyPelmard.getSVG(level)));
}

if (keccak256(abi.encodePacked("Pajtim Kasami")) == keccak256(abi.encodePacked(name)) ) {
  _svg = string(abi.encodePacked(svg, pajtimKasami.getSVG(level)));
}

if (keccak256(abi.encodePacked("Liam Millar")) == keccak256(abi.encodePacked(name)) ) {
  _svg = string(abi.encodePacked(svg, liamMillar.getSVG(level)));
}

if (keccak256(abi.encodePacked("Heinz Lindner")) == keccak256(abi.encodePacked(name)) ) {
  _svg = string(abi.encodePacked(svg, heinzLindner.getSVG(level)));
}

}











}
