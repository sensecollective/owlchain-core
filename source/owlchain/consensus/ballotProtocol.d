module owlchain.consensus.ballotProtocol;

import std.container;
import std.conv;
import std.json;
import std.algorithm : find;

import owlchain.xdr.type;
import owlchain.xdr.statement;
import owlchain.xdr.statementType;
import owlchain.xdr.hash;
import owlchain.xdr.envelope;
import owlchain.xdr.value;
import owlchain.xdr.quorumSet;
import owlchain.xdr.nodeID;
import owlchain.xdr.ballot;

import owlchain.consensus.consensusProtocol;
import owlchain.consensus.consensusProtocolDriver;
import owlchain.consensus.slot;
import owlchain.consensus.localNode;

alias StatementPredicate = bool delegate(ref const Statement st);

class BallotProtocol
{
private :
    Slot _slot;
    bool _heardFromQuorum;

    // state tracking members
    enum CPPhase
    {
        CP_PHASE_PREPARE,
        CP_PHASE_CONFIRM,
        CP_PHASE_EXTERNALIZE,
        CP_PHASE_NUM
    };

    // human readable names matching SCPPhase
    string[] _phaseNames;

    Ballot*[] _currentBallot;      // b
    Ballot*[] _prepared;           // p    
    Ballot*[] _preparedPrime;      // p'
    Ballot*[] _highBallot;         // h
    Ballot*[] _commit;             // c
    Envelope[NodeID] _latestEnvelopes; // M
    CPPhase   _phase;                                // Phi

    int _currentMessageLevel; // number of messages triggered in one run

    Array!(Envelope *)  _lastEnvelope; // last envelope generated by this node

    Array!(Envelope *)  _lastEnvelopeEmit; // last envelope emitted by this node

public :
    this(Slot value)
    {
        _slot = value;
        _heardFromQuorum = true;
        _phase = CPPhase.CP_PHASE_PREPARE;
        _currentMessageLevel = 0;
    }

    // Process a newly received envelope for this slot and update the state of
    // the slot accordingly.
    // self: set to true when node feeds its own statements in order to
    // trigger more potential state changes
    ConsensusProtocol.EnvelopeState processEnvelope(ref const Envelope envelope, bool self)
    {
        // incomplete
        return ConsensusProtocol.EnvelopeState.INVALID;
    }

    void ballotProtocolTimerExpired()
    {
        // incomplete
    }

    // abandon's current ballot, move to a new ballot
    // at counter `n` (or, if n == 0, increment current counter)
    bool abandonBallot(uint32 n)
    {
        // incomplete
        return false;
    }

    // bumps the ballot based on the local state and the value passed in:
    // in prepare phase, attempts to take value
    // otherwise, no-ops
    // force: when true, always bumps the value, otherwise only bumps
    // the state if no value was prepared
    bool bumpState(ref const Value value, bool force)
    {
        // incomplete
        return false;
    }

    // flavor that takes the actual desired counter value
    bool bumpState(ref const Value value, uint32 n)
    {
        // incomplete
        return false;
    }

    // ** status methods

    // returns information about the local state in JSON format
    // including historical statements if available
    void dumpInfo(ref JSONValue ret)
    {
        // incomplete
    }

    // returns information about the quorum for a given node
    void dumpQuorumInfo(ref JSONValue ret, ref const NodeID id, bool summary)
    {
        // incomplete

    }

    // returns the hash of the QuorumSet that should be downloaded
    // with the statement.
    // note: the companion hash for an EXTERNALIZE statement does
    // not match the hash of the QSet, but the hash of commitQuorumSetHash
    static Hash getCompanionQuorumSetHashFromStatement(ref const Statement st)
    {
        // incomplete
        Hash res;
        return res;
    }

    // helper function to retrieve b for PREPARE, P for CONFIRM or
    // c for EXTERNALIZE messages
    static Ballot getWorkingBallot(ref const Statement st)
    {
        // incomplete
        Ballot res;
        return res;
    }

    Envelope * getLastMessageSend() 
    {
        Envelope * e;
        if (_lastEnvelopeEmit.length > 0)
        {
            e = _lastEnvelopeEmit.front;
            _lastEnvelopeEmit.linearRemove(_lastEnvelopeEmit[0..0]);
            return e;
        }
        else
        {
            return null;
        }
    }

    void setStateFromEnvelope(ref const Envelope e)
    {
        // incomplete
    }

    const Envelope[] getCurrentState() 
    {
        // incomplete
        Envelope[] res;
        return res;
    }

    const Envelope[] getExternalizingState() 
    {
        // incomplete
        Envelope[] res;
        return res;
    }

private:
    // attempts to make progress using the latest statement as a hint
    // calls into the various attempt* methods, emits message
    // to make progress
    void advanceSlot(ref const Statement hint)
    {

    }

    // returns true if all values in statement are valid
    ConsensusProtocolDriver.ValidationLevel validateValues(ref const Statement st)
    {
        // incomplete
        return ConsensusProtocolDriver.ValidationLevel.kInvalidValue;
    }

    // send latest envelope if needed
    void sendLatestEnvelope()
    {
        // incomplete
    }

    // `attempt*` methods are called by `advanceSlot` internally call the
    //  the `set*` methods.
    //   * check if the specified state for the current slot has been
    //     reached or not.
    //   * idempotent
    //  input: latest statement received (used as a hint to reduce the
    //  space to explore)
    //  output: returns true if the state was updated

    // `set*` methods progress the slot to the specified state
    //  input: state specific
    //  output: returns true if the state was updated.

    // step 1 and 5 from the SCP paper
    bool attemptPreparedAccept(ref const Statement hint)
    {
        // incomplete
        return false;
    }

    // prepared: ballot that should be prepared
    bool setPreparedAccept(ref const Ballot prepared)
    {
        // incomplete
        return false;
    }

    // step 2+3+8 from the SCP paper
    // ballot is the candidate to record as 'confirmed prepared'
    bool attemptPreparedConfirmed(Statement hint)
    {
        // incomplete
        return false;
    }

    // newC, newH : low/high bounds prepared confirmed
    bool setPreparedConfirmed(ref const Ballot newC, ref const Ballot newH)
    {
        // incomplete
        return false;
    }

    // step (4 and 6)+8 from the SCP paper
    bool attemptAcceptCommit(ref const Statement hint)
    {
        // incomplete
        return false;
    }

    // new values for c and h
    bool setAcceptCommit(ref const Ballot c, ref const Ballot h)
    {
        // incomplete
        return false;
    }

    // step 7+8 from the SCP paper
    bool attemptConfirmCommit(ref const Statement hint)
    {
        // incomplete
        return false;
    }

    bool setConfirmCommit(ref const Ballot acceptCommitLow, ref const Ballot acceptCommitHigh)
    {
        // incomplete
        return false;
    }

    // step 9 from the SCP paper
    bool attemptBump()
    {
        // incomplete
        return false;
    }

    // computes a list of candidate values that may have been prepared
    BallotSet getPrepareCandidates(ref const Statement hint)
    {
        // incomplete
        BallotSet res = new BallotSet;
        return res;
    }

    // helper to perform step (8) from the paper
    void updateCurrentIfNeeded()
    {
        // incomplete
    }

    // An interval is [low,high] represented as a pair
    //using Interval = std::pair<uint32, uint32>;

    // helper function to find a contiguous range 'candidate' that satisfies the
    // predicate.
    // updates 'candidate' (or leave it unchanged)
    //static void findExtendedInterval(Interval& candidate,
    //                                 std::set<uint32> const& boundaries,
    //                                 std::function<bool(Interval const&)> pred);

    // constructs the set of counters representing the
    // commit ballots compatible with the ballot
    uint32[] getCommitBoundariesFromStatements(ref const Ballot ballot)
    {
        // incomplete
        uint32[] res;
        return res;
    }

    // ** helper predicates that evaluate if a statement satisfies
    // a certain property

    // is ballot prepared by st
    static bool hasPreparedBallot(ref const Ballot ballot, ref const Statement st)
    {
        // incomplete
        return false;
    }

    // returns true if the statement commits the ballot in the range 'check'
    //static bool commitPredicate(ref const Ballot ballot, Interval const& check, ref const Statement st)
    //{
    // incomplete
    //}

    // attempts to update p to ballot (updating p' if needed)
    bool setPrepared(ref const Ballot ballot)
    {
        // incomplete
        return false;
    }

    // ** Helper methods to compare two ballots

    // ballot comparison (ordering)
    //static int compareBallots(std::unique_ptr<SCPBallot> const& b1,
    //                          std::unique_ptr<SCPBallot> const& b2);
    //static int compareBallots(SCPBallot const& b1, SCPBallot const& b2);

    // b1 ~ b2
    static bool areBallotsCompatible(ref const Ballot b1, ref const Ballot b2)
    {
        // incomplete
        return false;
    }

    // b1 <= b2 && b1 !~ b2
    static bool areBallotsLessAndIncompatible(ref const Ballot b1, ref const Ballot b2)
    {
        // incomplete
        return false;
    }

    // b1 <= b2 && b1 ~ b2
    static bool areBallotsLessAndCompatible(ref const Ballot b1, ref const Ballot b2)
    {
        // incomplete
        return false;
    }

    // ** statement helper functions

    // returns true if the statement is newer than the one we know about
    // for a given node.
    bool isNewerStatement(ref const NodeID nodeID, ref const Statement st)
    {
        // incomplete
        return false;
    }

    // returns true if st is newer than oldst
    static bool isNewerStatement(ref const Statement oldst, ref const Statement st)
    {
        // incomplete
        return false;
    }

    // basic sanity check on statement
    static bool isStatementSane(ref const Statement st, bool self)
    {
        // incomplete
        return false;
    }

    // records the statement in the state machine
    void recordEnvelope(ref const Envelope env)
    {
        // incomplete
    }

    // ** State related methods

    // helper function that updates the current ballot
    // this is the lowest level method to update the current ballot and as
    // such doesn't do any validation
    // check: verifies that ballot is greater than old one
    void bumpToBallot(ref const Ballot ballot, bool check)
    {
        // incomplete
    }

    // switch the local node to the given ballot's value
    // with the assumption that the ballot is more recent than the one
    // we have.
    bool updateCurrentValue(ref const Ballot ballot)
    {
        // incomplete
        return false;
    }

    // emits a statement reflecting the nodes' current state
    // and attempts to make progress
    void emitCurrentStateStatement()
    {
        // incomplete
    }

    // verifies that the internal state is consistent
    void checkInvariants()
    {
        // incomplete
    }

    // create a statement of the given type using the local state
    Statement createStatement(ref const StatementType type)
    {
        // incomplete
        Statement res;
        return res;
    }

    // returns a string representing the slot's state
    // used for log lines
    string getLocalState() 
    {
        // incomplete
        return "";
    }

    LocalNode getLocalNode()
    {
        // incomplete
        LocalNode res;
        return res;
    }

    bool federatedAccept(StatementPredicate voted, StatementPredicate accepted)
    {
        // incomplete
        return false;
    }

    bool federatedRatify(StatementPredicate voted)
    {
        // incomplete
        return false;
    }

    void startBallotProtocolTimer()
    {
        // incomplete
    }

}