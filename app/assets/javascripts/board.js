// $(document).ready(function(){
// 	var fenStr = "";
// 	$.ajax({
// 		url: "/position",
// 		dataType: "json"
// 	}).then(function(data) {
// 		console.log(data);
// 		fenStr = data.position;

// 	var board,
// 	  game = new Chess(fenStr),

// 	  statusEl = $('#status'),
// 	  fenEl = $('#fen'),
// 	  pgnEl = $('#pgn'),
// 	  movesEl = $('#moves');

// 	// do not pick up pieces if the game is over
// 	// only pick up pieces for the side to move
// 	var onDragStart = function(source, piece, position, orientation) {
// 	  if (game.game_over() === true ||
// 	      (game.turn() === 'w' && piece.search(/^b/) !== -1) ||
// 	      (game.turn() === 'b' && piece.search(/^w/) !== -1)) {
// 	    return false;
// 	  }
// 	};

// 	var onDrop = function(source, target) {
// 	  // see if the move is legal
// 	  let prev = game.fen();
// 	  var move = game.move({
// 	    from: source,
// 	    to: target,
// 	    promotion: 'q' // NOTE: always promote to a queen for example simplicity
// 	  });


// 	  // illegal move
// 	  if (move === null)
// 	  	return 'snapback';
// 	  else {
// 	  	$.ajax({
// 		  	url: '/moves',
// 		  	type: 'POST',
// 		  	data: {
// 		  		move: {
// 		  		position: prev,
// 		  		resulting_position: game.fen(),
// 		  		san: move.san
// 		  		// likelihood
// 		  	}
// 		  }
// 		  });
// 	  }

// 	  updateStatus();
// 	};

// 	// update the board position after the piece snap 
// 	// for castling, en passant, pawn promotion
// 	var onSnapEnd = function() {
// 	  board.position(game.fen());
// 	};

// 	var updateStatus = function() {
// 	  var status = '';

// 	  var moveColor = 'White';
// 	  if (game.turn() === 'b') {
// 	    moveColor = 'Black';
// 	  }

// 	  // checkmate?
// 	  if (game.in_checkmate() === true) {
// 	    status = 'Game over, ' + moveColor + ' is in checkmate.';
// 	  }

// 	  // draw?
// 	  else if (game.in_draw() === true) {
// 	    status = 'Game over, drawn position';
// 	  }

// 	  // game still on
// 	  else {
// 	    status = moveColor + ' to move';

// 	    // check?
// 	    if (game.in_check() === true) {
// 	      status += ', ' + moveColor + ' is in check';
// 	    }
// 	  }

// 	  $.ajax({
// 	  	url: 'https://expl.lichess.org/master?fen='+game.fen(),
// 	  	dataType: "json"
// 	  }).then(function(data){
// 	  	movesEl.empty();
// 	  	let total = data.white+data.draws+data.black;
// 	  	data.moves.forEach((move) => {
// 	  		let moveTotal = move.white+move.draws+move.black;
// 	  		let percent = moveTotal/total * 100;
// 	  		if (percent > 0.1)
// 	  			movesEl.append("<p>"+move.san+": "+percent.toFixed(1)+"%</p>");
// 	  	});
// 	  });



// 	  statusEl.html(status);
// 	  fenEl.html(game.fen());
// 	  pgnEl.html(game.pgn());
// 	};

// 	var cfg = {
// 	  draggable: true,
// 	  position: fenStr,
// 	  onDragStart: onDragStart,
// 	  onDrop: onDrop,
// 	  onSnapEnd: onSnapEnd
// 	};
// 	board = ChessBoard('board', cfg);

// 	updateStatus();
// });
// });